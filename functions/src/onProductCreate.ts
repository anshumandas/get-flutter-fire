import * as functions from "firebase-functions";
import { admin } from "./config";
import { notificationsRef } from "./helper/firebaseHelper";
import { Product, NotificationData } from "./helper/typeHelper";

export const onProductCreate = functions.firestore
  .document("products/{productId}")
  .onCreate(async (snapshot, context) => {
    const product = snapshot.data() as Product;
    try {
      
      await sendProductNotification(product, context.eventId);
    } catch (error) {
      console.error("Error creating product link:", error);
    }
  });

async function sendProductNotification(
  product: Product,
  eventId: string
): Promise<void> {
  try {
    const notificationPayload: admin.messaging.Message = {
      notification: {
        title: "Exciting News!",
        body: `Introducing ${product.name_en} - Your new must-have! Check it out now!`,
        imageUrl: product.images[0],
      },
      data: {
        routeName: "product",
        parameterID: product.id,
        click_action: "FLUTTER_NOTIFICATION_CLICK",
      },
      topic: "new-product",
    };

    const response = await admin.messaging().send(notificationPayload);
    console.log("Notification sent:", response);

    const notificationData: NotificationData = {
      id: eventId,
      userID: "all",
      title: "Exciting News!",
      body: `Introducing ${product.name_en} - Your new must-have! Check it out now!`,
      isRead: false,
      imageUrl: product.images[0],
      notificationType: "product",
      url: `/product?id=${product.id}`,
    };

    await notificationsRef().doc(eventId).set(notificationData);
    console.log("Notification data stored in Firestore.");
  } catch (error) {
    console.error("Error sending product notification:", error);
  }
}
