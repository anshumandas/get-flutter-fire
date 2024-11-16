export enum EntryAction {
    CREATE = "created",
    UPDATE = "updated",
    DELETE = "deleted"
}

export enum UserAction { //each could be used as a type in Edge
    VIEW = "view",
    FOLLOW = "follow",
    REACT = "react",
    SHARE = "share",
    INVITE = "invite"
}

export enum State {
    NEW = "new",
    EDITED = "edited",
    WORKFLOW = "workflow",
    REACTIVED = "reactived", //the above is state before set as active
    ACTIVE = "active", // same as added in case of links
    INACTIVE = "inactive", // = "deleted", removed
    //used for links
    BLOCKED = "blocked"
}

export enum ReactionType {
    LOVE = "LOVE",//+1
    HATE = "HATE" //-1
}
