import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// Check if the Firebase Admin SDK is already initialized
if (!admin.apps.length) {
  admin.initializeApp();
}

import { createNotificationMessage } from "./helper/messageHelpers";
import { getUser } from "./helper/getUserHelper";
import { notificationsRef } from "./helper/firebaseHelper";
import { Order, User, NotificationData } from "./helper/typeHelper";

export const onOrderCreate = functions.firestore
  .document("orders/{orderId}")
  .onCreate(async (snapshot, context) => {
    const order = snapshot.data() as Order;
    const user = (await getUser(order.userID)) as User;

    if (!user) {
      console.error(`User with ID ${order.userID} not found`);
      return;
    }

    await Promise.all([
      sendOrderPlacedNotification(order, context.eventId, user),
    ]);
  });

async function sendOrderPlacedNotification(
  order: Order,
  eventID: string,
  user: User
) {
  try {
    // Check if fcmTokens is defined and is an array
    if (Array.isArray(user.fcmTokens) && user.fcmTokens.length > 0) {
      const message = createNotificationMessage(
        order.currentStatus,
        user.fcmTokens,
        "orderDetail",
        order.id
      );

      const notificationData: NotificationData = {
        id: eventID,
        userID: user.id,
        title: message.notification.title,
        body: message.notification.body,
        isRead: false,
        imageUrl: null,
        notificationType: "order",
        url: `/orderDetail?id=${order.id}`,
      };

      await notificationsRef().doc(eventID).set(notificationData);
      console.log("Notification data stored in Firestore.");

      const response = await admin.messaging().sendEachForMulticast(message);
      console.log("Notification sent successfully:", response);
    } else {
      console.log("User does not have any FCM tokens.");
    }
  } catch (error) {
    console.error("Error sending order placed notification:", error);
  }
}
