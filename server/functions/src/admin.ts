/* eslint-disable curly */
/* eslint-disable object-curly-spacing */
/* eslint-disable prefer-arrow-callback */
/* eslint-disable space-before-function-paren */
/* eslint-disable indent */
/* eslint-disable block-spacing */
/* eslint-disable brace-style */
/* eslint-disable no-var */
/* eslint-disable no-invalid-this */
/* eslint-disable valid-jsdoc */
/* eslint-disable camelcase */
/* eslint-disable require-jsdoc */
/* eslint-disable max-len */

// import { debug } from "firebase-functions/logger";
import admin from "firebase-admin";

const adminAuth = admin.auth();


// Note on Typescript Enums: https://www.crocoder.dev/blog/typescript-enums-good-bad-and-ugly/
// https://dev.to/ivanzm123/dont-use-enums-in-typescript-they-are-very-dangerous-57bh
// and https://graphqleditor.com/blog/enums-are-still-bad/
const Roles = [
    "guest",
    "buyer",
    "seller",
    "admin"
 ] as const;

type RoleType = (typeof Roles)[number];

// // Or we could have it as an object if we don't need the order
// const Roles = {
//     Admin: "admin",
//     Seller: "seller",
//     Buyer: "buyer"
//   } as const;
  
// // Convert object key in a type
// type RoleType = typeof Roles[keyof typeof Roles]
  
function hasAccess(role: RoleType, access: RoleType): boolean {
    return Roles.indexOf(role) >= Roles.indexOf(access);
}

// TODO use this to add/change User Roles and Permissions

export {adminAuth, hasAccess};