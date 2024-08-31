
//order type
export interface Order {
    id: string;
    userID: string;
    currentStatus: string;
  }
  //user type
  export interface User {
    id: string;
    phoneNumber: string;
    fcmTokens: string[];
    fullName: string;
  }
  //notification type
  export interface NotificationData {
    id: string;
    userID: string;
    title: string;
    body: string;
    isRead: boolean;
    imageUrl: string | null;
    notificationType: string;
    url: string;
  }
  //product type
  export interface Product {
    id: string;
    name_en: string;
    images: string[];
  }
 

  