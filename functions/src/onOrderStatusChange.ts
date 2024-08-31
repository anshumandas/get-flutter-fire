import * as functions from "firebase-functions";
import { admin } from "./config";
import {
  createNotificationMessage,
} from "./helper/messageHelpers";
import { getUser } from "./helper/getUserHelper";
import { notificationsRef } from "./helper/firebaseHelper";
import { Order, User, NotificationData } from "./helper/typeHelper";

export const onOrderStatusUpdate = functions.firestore
  .document("orders/{orderId}")
  .onUpdate(async (change, context) => {
    const newValue = change.after.data() as Order;
    const oldValue = change.before.data() as Order;

    if (newValue.currentStatus !== oldValue.currentStatus) {
      const user = (await getUser(newValue.userID)) as User;

      if (!user) {
        console.error(`User with ID ${newValue.userID} not found`);
        return;
      }

      await Promise.all([
        sendOrderStatusNotification(newValue, user, context.eventId),
       
      ]);
    }
  });

async function sendOrderStatusNotification(
  order: Order,
  user: User,
  eventID: string
): Promise<void> {
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
    console.error("Error sending order status notification:", error);
  }
}

