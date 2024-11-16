import { EntryAction, State } from "./enums";

export type ref = string | {//this is a reference to another document
    link: string; //to a Data node id. has both type and id info and can be path to sub item
    summary?:string;
    version?:number
}

export type image = string; //image path to storage
export type opaque = string; //the string must be a randomly generated alphanumeric
export type SetId = string;
export type SetEntry = string | {
    name: string;
}

export interface Entry { //this is used as document in the versions collection
    id: string;//must be unique
    type: string;//parent collection name
    version:number //current version
    by: ref; //to user ref
    on: Date;//used for sorting for New
    action: EntryAction
}

// New Post is not necessarily a Data
export interface Data extends Entry { 
    status: State;
    u_on?: Date;//used for secondary sorting for New after created
    u_by?: ref;//used for secondary sorting for New after created
    score?: number;//used for sorting for Top. calculated based on reactions and followers;
}

export class NewData<T> implements Data {
    constructor (type: string, data:T, id: string, by: ref) {
        Object.assign(this, data);
        //overwrites the following in existing data
        this.type = type;
        this.id = id;
        this.by = by; 
        this.on = new Date();
    }
    status = State.NEW;
    id: string;
    type: string;
    version = 1;
    by: ref;
    on: Date;
    action = EntryAction.CREATE;

}
