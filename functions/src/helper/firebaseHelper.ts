import { admin } from "../config";

export const ordersRef = () => {
  return admin.firestore().collection("orders");
};

export const usersRef = () => {
  return admin.firestore().collection("users");
};

export const notificationsRef = () => {
  return admin.firestore().collection("notifications");
};
