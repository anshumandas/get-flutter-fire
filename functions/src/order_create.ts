import * as functions from "firebase-functions";
import { admin } from "./config";
import { createNotificationMessage } from "./helpers/message_data";
import { getUser } from "./helpers/get_user";
import { notificationsRef } from "./helpers/firebase_globals";
import { Order, User, NotificationData } from "./helpers/interfaces";

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
    if (user.fcmTokens.length > 0) {
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
    }
  } catch (error) {
    console.error("Error sending order placed notification:", error);
  }
}
