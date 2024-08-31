export function createOrderUpdateMessage(
  status: string,
  username: string,
  orderID: string
): string {
  const messages: { [key: string]: string } = {
    placed: `Exciting news, ${username}! Your order (ID: ${orderID}) has been placed!`,
    processed: `Exciting news, ${username}! Your order (ID: ${orderID}) has been processed and is getting ready!`,
    shipped: `Great, ${username}! Your order (ID: ${orderID}) is on its way!`,
    delivered: `Hooray, ${username}! Your order (ID: ${orderID}) has been delivered! Enjoy your purchase!`,
    cancelled: `We're sorry, ${username}. Your order (ID: ${orderID}) has been cancelled. If you have any questions, please contact us.`,
  };

  return (
    messages[status] ||
    `Hello, ${username}. Your order (ID: ${orderID}) status has changed to ${status}. If you have any questions, please contact us.`
  );
}

export function createNotificationMessage(
  status: string,
  tokens: string[],
  routeName: string,
  parameterID: string
) {
  let title = "Order Update!";
  let body = "";

  switch (status) {
    case "placed":
      title = "Order Placed!";
      body = "Exciting news! Your order has been placed!";
      break;
    case "processed":
      title = "Order Processed!";
      body =
        "Exciting news! Your order has been processed and is getting ready!";
      break;
    case "shipped":
      title = "Order Shipped!";
      body = "Great! Your order is on its way!";
      break;
    case "delivered":
      title = "Order Delivered!";
      body = "Hooray! Your order has been delivered! Enjoy your purchase!";
      break;
    case "cancelled":
      title = "Order Cancelled";
      body =
        "We're sorry. Your order has been cancelled. If you have any questions, please contact us.";
      break;
    default:
      body = `Your order status has changed to ${status}.`;
  }

  return {
    notification: {
      title: title,
      body: body,
    },
    data: {
      routeName: routeName,
      parameterID: parameterID,
      click_action: "FLUTTER_NOTIFICATION_CLICK",
    },
    tokens: tokens,
  };
}
