import { opaque, ref } from "./base";
import { SocialNode } from "./social";

export type userRef = ref; //ref which is for a user

//Accessible to other Users
export interface User extends SocialNode {
    id: opaque; //User data needs to have opaque id
}

// Profile is visible to User for self only
export interface UserProfile extends User {
    dob: Date;
}