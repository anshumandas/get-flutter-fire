import { Data, NewData } from "./models/base";

export class SearchParams {
  path!: string;
  filters?: {[key:string]: any};
  limit?:number; 
  marker?: string;
  activeOnly?:boolean;
  oldestFirst?: boolean;
  joins?: SearchParams; // state multiple paths and use the above filter to join
}

export type ComboKeys = string[]; //combination of the keys in the array makes one Unique Constraint
export type MultipleSeparateKeys = ComboKeys[]; //each item in this array is a separate Unique Constraint
export type WhereFilterOp =
| '<'
| '<='
| '=='
| '!='
| '>='
| '>'
| 'array-contains'
| 'in'
| 'not-in'
| 'array-contains-any';

export abstract class DB_API {
  static tableName = process.env.TABLENAME; //single table paradigm. This goes in the path
  static singleton: DB_API;
  observers: {[key:string]: Function} = {};
  logger: any;

  // All Rolebased Auth at API layer middleware
  public abstract create<X, T extends NewData<X>>(type: (new (...args: any[]) => T), path: string, object:X, by?: string, uniqueKeys?: MultipleSeparateKeys, reactivate?: boolean): Promise<T>; //returns id. Only case where by can be omitted is when its user adding self
  // if read access log required it has to be managed at API layer
  public abstract queryByID(path: string, id: string): Promise<Data|undefined>;
  //filters are not from query path but from auth and ownership
  public abstract queryMany(path: string, filters?: {[key:string]: {op:WhereFilterOp, value:any}}, limit?:number, marker?: string, activeOnly?:boolean, oldestFirst?: boolean): Promise<Data[]>;
  public abstract search(params:SearchParams): Promise<Data[]>; //this is used with POST and not GET. Can be a JOIN
  public abstract subscribe(params: SearchParams, callback:Function): Promise<Function>;
  public abstract updateByID(path: string, id: string, object:Data, by: string): Promise<Data>; //returns older data
  public abstract inactivateByID(path: string, id: string, by: string): Promise<Data>; //returns data

  public abstract listenOnCreate(path: string, listenerName: string, callback:Function):any;
  public abstract listenOnUpdate(path: string, listenerName: string, callback:Function):any; //No Delete should be allowed
}

export function init(db:DB_API) {
  DB_API.singleton = db;
  if(process.env.ENV && process.env.ENV !== "NONE") {
    DB_API.tableName = DB_API.tableName + '-' + process.env.ENV;
  }
  // Add listeners
  db.listenOnCreate("/users/{id}", "onUserAdded", () => {});
  return DB_API.singleton.observers;
}