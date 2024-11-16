import { Data, ref, image, Entry } from "./base";
import { EntryAction, ReactionType, State } from "./enums";

export interface SocialNode extends Data { //Any data that can be liked and followed
    status: State;// = State.NEW;
    updated?: Date | undefined;
    score?: number | undefined;
    id: string;
    type: string;
    version: number;
    by: ref;
    on: Date;
    action: EntryAction;// = EntryAction.CREATE; 

    name?: string;//not necessarily unique, actual known name, title
    image?:image
    views?: number;
    reactions?: number;
    followers?:number;
}

export interface Comment extends SocialNode {
    topic: ref; //the comment is made on the topic. Could be another comment
    description?: string;
}

export interface Edge extends Entry {
    id: string;
    type: string; //relationship name could be UserAction
    version: number;
    by: ref;
    on: Date;
    action: EntryAction;

    from: ref;
    to: ref;
}

export interface Reaction extends Edge {
    reaction: ReactionType; //additional property in an Edge
}