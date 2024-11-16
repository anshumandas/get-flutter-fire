/* eslint-disable valid-jsdoc */
import {FirestoreAuthEvent, FirestoreEvent, onDocumentCreated, onDocumentUpdatedWithAuthContext} from "firebase-functions/v2/firestore";
import {Query, DocumentData, getFirestore, FirestoreDataConverter, QueryDocumentSnapshot, Filter} from "firebase-admin/firestore";
import {database} from "myserver";
import {Data, NewData} from "myserver/dist/common/models/base";
import {Change, logger as Logger, https} from "firebase-functions";
import {State} from "myserver/dist/common/models/enums";
import {ComboKeys, MultipleSeparateKeys} from "myserver/dist/common/dal";

const db = getFirestore();

export class FireStoreDB extends database.DB_API implements FirestoreDataConverter<Data, DocumentData> {
  constructor() {
    super();
    this.logger = Logger;
  }
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  toFirestore(modelObject: Data, options?: unknown): FirebaseFirestore.PartialWithFieldValue<DocumentData> | FirebaseFirestore.WithFieldValue<DocumentData> {
    const m = modelObject as DocumentData;
    return m;
  }
  fromFirestore(snapshot: FirebaseFirestore.QueryDocumentSnapshot): Data {
    const data = snapshot.data();
    const d = (data.id == "") ? {...data, id: snapshot.id} : data;
    return d as Data;
  }
  async queryByID(path: string, id: string): Promise<Data|undefined> {
    const doc = db.doc(path+"/"+id).withConverter<Data, DocumentData>(this);
    // const pointer: CollectionReference = this.getCollectionByPath(path);
    // const doc: DocumentReference = pointer.doc(id);
    const d = await doc.get();
    if (d.exists) return d.data();
    throw new Error("Does not exist");
  }
  // private getCollectionByPath(path: string) : CollectionReference {
  //   const splits = path.split("/");
  //   if (splits.length % 2 == 0) throw new Error("Wrong Path");
  //   // eslint-disable-next-line @typescript-eslint/no-explicit-any
  //   let pointer: any = db;
  //   for (let index = 0; index < splits.length; index++) {
  //     const element = splits[index];
  //     pointer = (index % 2 == 0) ? pointer.collection(element) : pointer.doc(element);
  //   }
  //   return pointer as CollectionReference;
  // }

  /**
   * Query Indexing should be done, app specific, at the Firestore console level
   * See https://firebase.google.com/docs/firestore/query-data/indexing
  */
  // eslint-disable-next-line @typescript-eslint/no-explicit-any, @typescript-eslint/no-unused-vars
  async queryMany(path: string, filters?: {[key:string]: {op:database.WhereFilterOp, value:any}}, _limit?: number, marker?: string, activeOnly?: boolean, oldestFirst?: boolean): Promise<Data[]> {
    const pointer: Query<Data, DocumentData> = this.getQueryRef(path, filters, activeOnly, _limit, marker);
    // if (oldestFirst) pointer = pointer.orderBy("on", "asc"); //this is by default due to the id having timestamp
    const docs = (await pointer.get()).docs;
    return docs.map((doc) => {
      return doc.data();
    });
  }
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  private getQueryRef(path: string, filters: { [key: string]: { op: database.WhereFilterOp; value: any; }; } | undefined, activeOnly: boolean | undefined, _limit: number | undefined, marker: string | undefined) : Query<Data, DocumentData> {
    let pointer: Query<Data, DocumentData> = db.collection(path).withConverter<Data, DocumentData>(this); // this.getCollectionByPath(path);
    if (filters) {
      // eslint-disable-next-line guard-for-in
      for (const key in filters) {
        const element = filters[key];
        pointer = pointer.where(key, element.op, element.value);
      }
    }
    if (activeOnly) pointer = pointer.where("status", "==", "active");
    pointer = pointer.limit(_limit || 20);
    if (marker != null) pointer = pointer.startAfter(marker);
    return pointer;
  }

  async search(params: database.SearchParams): Promise<Data[]> {
    // TODO this could be joins on multiple paths or text search
    // TODO use Collection Groups concept for query across sub collections
    return this.queryMany(params.path, params.filters, params.limit, params.marker, params.activeOnly, params.oldestFirst);
  }
  // Subscribe to changes on a specific set of data
  // eslint-disable-next-line @typescript-eslint/ban-types
  async subscribe(params: database.SearchParams, callback: (snapshot: FirebaseFirestore.QuerySnapshot<Data, DocumentData>) => void): Promise<Function> {
    // TODO this could be joins on multiple paths or text search
    // TODO use Collection Groups concept for query across sub collections
    const query: Query<Data, DocumentData> = this.getQueryRef(params.path, params.filters, params.activeOnly, params.limit, params.marker);
    return query.onSnapshot(callback);
  }
  async updateByID(path: string, id: string, object: Data, by: string): Promise<Data> {
    // update of uniqueKey values should not be allowed in API layer or else requires deletion of index and creating new one
    const d = db.collection(path).doc(id).withConverter(this);
    // TODO this should be in a transaction. state and version should also be checked
    const old = await d.get();
    if (!old.exists) throw new https.HttpsError("permission-denied", "data does not exist. use create instead");
    d.set({...object, u_by: by, u_on: new Date()}, {merge: true}); // TODO add versioning
    // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
    return old.data()!;
  }
  async inactivateByID(path: string, id: string, by: string): Promise<Data> {
    // TODO inacive data unique index needs deletion or we need to manage reactivation cycle
    const d = db.collection(path).doc(id).withConverter(this);
    const old = await d.get();
    if (!old.exists) throw new https.HttpsError("permission-denied", "data does not exist.");
    d.set({status: State.INACTIVE, u_by: by, u_on: new Date()}, {merge: true});
    // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
    return old.data()!;
  }

  /**
   * Uniqueness checking done via uniqueIndex collection for top level
   * See https://stackoverflow.com/questions/47543251/firestore-unique-index-or-unique-constraint
   * For every /{collection}/{id} we have /uniqueIndex/{collection}/{indexName}/{indexValue}
   * For Sub Collections, traverse the entire collection to check
   */
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  async create<X, T extends NewData<X>>(Type: (new (...args: any[]) => T), path: string, obj: X, by?: string, uniqueKeys?: MultipleSeparateKeys, reactivate?: boolean): Promise<T> {
    this.logger.log("creating : " + path);
    if (path != "users" && by == null) throw new Error("creator info missing");
    if (uniqueKeys != null) {
      if (!path.includes("/") && !reactivate && uniqueKeys.length == 1) {
        // top level single primary key and non reactivation case. Less expensive operation
        const batch = db.batch();
        const Collection = db.collection(path);
        const ref = Collection.doc();
        const combo: ComboKeys = uniqueKeys[0];
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        const values: any[] = [];
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        combo.forEach((val) => values.push((obj as any)[val]));
        const val = values.join("|");
        const key = "primaryKey";
        const entry:T = new Type({...obj, [key]: val}, ref.id, by || ref.id);
        batch.set(ref, toPlainFirestoreObject(entry)); // https://stackoverflow.com/questions/52221578/firestore-doesnt-support-javascript-objects-with-custom-prototypes
        const Index = db.collection("uniqueIndex");
        const indexRef = Index.doc(`${path}/${key}/${val}`);
        if ((await indexRef.get()).exists) {
          throw new https.HttpsError("permission-denied", "data with same unique fields already exists");
        }
        batch.set(indexRef, {
          value: ref.id,
        });
        await batch.commit();
        return entry;
      } else {
        // This scans the collection and is expensive
        return await db.runTransaction(async (t) => {
          const collectionRef:Query<unknown, DocumentData> = db.collection(path);
          const filters = [];
          for (let index = 0; index < uniqueKeys.length; index++) {
            const combo: ComboKeys = uniqueKeys[index];
            const wheres: Filter[] = [];
            combo.forEach((val) => {
              // eslint-disable-next-line @typescript-eslint/no-explicit-any
              wheres.push(Filter.where(val, "==", (obj as any)[val]));
            });
            filters.push(Filter.and(...wheres));
          }
          const q = collectionRef.where(Filter.or(...filters));
          const query = await t.get(q);
          if (query.docs.length > 0) {
            if (reactivate && (query.docs[0].data() as Data).status == State.INACTIVE) {
              // TODO go to reactivation flow

            } else {
              throw new https.HttpsError("permission-denied", "data with same unique fields already exists");
            }
          }
          const ref = db.collection(path).doc();
          const entry:T = new Type(obj, ref.id, by || ref.id);
          t.set(ref, toPlainFirestoreObject(entry));
          return entry;
        });
      }
    } else {
      const ref = db.collection(path).doc();
      const entry:T = new Type(obj, ref.id, by || ref.id);
      ref.set(toPlainFirestoreObject(entry));
      return entry;
    }
  }

  // Triggers
  // https://firebase.google.com/docs/firestore/query-data/listen Or

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  listenOnCreate(path: string, listenerName: string, callback: (event: FirestoreEvent<QueryDocumentSnapshot | undefined, Record<string, string>>) => any | Promise<any>) {
    // path => "/path/{id}/subpath/{subid}"
    const p = path.split("/");
    if (p.length == 3 && p[0] != "workitems") { // "/path/{id}"
      // initiate workflow if it exists else put state as active
      this.observers[listenerName] = onDocumentCreated(path, (e: FirestoreEvent<QueryDocumentSnapshot | undefined, Record<string, string>>) => {
        // const original = e.data!.data();
        // Access the parameter `{id}` with `event.params`
        // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
        e.data!.ref.set({status: State.ACTIVE}, {merge: true});
        return callback(e);
      });
    } else {
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      this.observers[listenerName] = onDocumentCreated(path, callback);
    }
  }
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  listenOnUpdate(path: string, listenerName: string, callback: (event: FirestoreAuthEvent<Change<QueryDocumentSnapshot> | undefined, Record<string, string>>) => any | Promise<any>) {
    // path => "/path/{id}/subpath/{subid}"
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    this.observers[listenerName] = onDocumentUpdatedWithAuthContext(path, callback);
  }
}
// eslint-disable-next-line @typescript-eslint/no-explicit-any
const toPlainFirestoreObject = (o: any): any => {
  if (o && typeof o === "object" && !Array.isArray(o) && !isFirestoreTimestamp(o)) {
    return {
      ...Object.keys(o).reduce(
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        (a: any, c: any) => ((a[c] = toPlainFirestoreObject(o[c])), a),
        {}
      ),
    };
  }
  return o;
};

// eslint-disable-next-line @typescript-eslint/no-explicit-any
function isFirestoreTimestamp(o: any): boolean {
  if (o && (o instanceof Date || (Object.getPrototypeOf(o).toMillis &&
    Object.getPrototypeOf(o).constructor.name === "Timestamp"))) {
    return true;
  }
  return false;
}

export const firestoredb = new FireStoreDB();
export const listeners = database.init(firestoredb);


