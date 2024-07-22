"use strict";
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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.adminAuth = void 0;
exports.hasAccess = hasAccess;
// import { debug } from "firebase-functions/logger";
const firebase_admin_1 = __importDefault(require("firebase-admin"));
const adminAuth = firebase_admin_1.default.auth();
exports.adminAuth = adminAuth;
// Note on Typescript Enums: https://www.crocoder.dev/blog/typescript-enums-good-bad-and-ugly/
// https://dev.to/ivanzm123/dont-use-enums-in-typescript-they-are-very-dangerous-57bh
// and https://graphqleditor.com/blog/enums-are-still-bad/
const Roles = [
    "guest",
    "buyer",
    "seller",
    "admin"
];
// // Or we could have it as an object if we don't need the order
// const Roles = {
//     Admin: "admin",
//     Seller: "seller",
//     Buyer: "buyer"
//   } as const;
// // Convert object key in a type
// type RoleType = typeof Roles[keyof typeof Roles]
function hasAccess(role, access) {
    return Roles.indexOf(role) >= Roles.indexOf(access);
}
//# sourceMappingURL=admin.js.map