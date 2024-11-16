import { SocialNode } from "./social";
import { ReactionType } from "./enums";
import { userRef } from "./user";

class _GenericExtend<T> {
    constructor(data: T) {
        const proto = { ..._GenericExtend.prototype };
        Object.assign(proto, Object.getPrototypeOf(data));
        Object.setPrototypeOf(this, proto);
        Object.assign(this, data);
    }
}

class _Response<T extends SocialNode> extends _GenericExtend<T> {
    //with user id join
    viewed?: boolean;
    reaction?: ReactionType;
    followed?:boolean;
}

export type Response<T extends SocialNode> = _Response<T> & T;
const Response: new <T extends SocialNode>(data: T) => Response<T> = _Response as any;

class _Request<T extends SocialNode> extends _GenericExtend<T> {
    requestor!: userRef; //this could be taken from auth header
}

export type Request<T extends SocialNode> = _Request<T> & T;
const Request: new <T extends SocialNode>(data: T) => Request<T> = _Request as any;
