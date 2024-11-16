import * as admin from "firebase-admin";
import {UserRecord} from "firebase-admin/auth";

const adminAuth = admin.auth();
export {adminAuth, UserRecord};
