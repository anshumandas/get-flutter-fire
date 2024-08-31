---

# Flutter Firebase GetX - (Sheru)

Welcome to the **Sheru, Your Own Ecommerce Platform**! This application is made on top of the give code structure using flutter-firebase-getx. The flow and structure is maintained throught the app. For better experience and web capabilities, the admin part is made seperately as an admin panel that can be used for controlling the app.

<p align="center">
   <img src="https://github.com/user-attachments/assets/fcd592ef-2f01-46a4-b018-b2fbaaf8d7c7" alt="Screenshot_3" width="300"/>
  <img src="https://github.com/user-attachments/assets/7ee15bea-a6ef-43a9-a7f5-ea9228d1330b" alt="Screenshot_1" width="300"/>
</p>
<p align="center">
   <img src="https://github.com/user-attachments/assets/9c35c220-1b5a-4c19-8cad-7b7bc9d20133" alt="Screenshot_2" width="300"/>
  <img src="https://github.com/user-attachments/assets/553c6ab2-9af7-4d3f-bac2-21cf1629dfe5" alt="Screenshot_7" width="300"/> 
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/711866a7-4d77-4895-b3c6-f2f3a75815be" alt="Screenshot_8" width="300"/>
  <img src="https://github.com/user-attachments/assets/cfd5c330-e358-4390-b52c-fe214912a119" alt="Screenshot_6" width="300"/>
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/8560aaeb-2c51-4988-9196-7705d6098c2f" alt="Screenshot_5" width="300"/>
   <img src="https://github.com/user-attachments/assets/fdcd7634-9439-4f61-8fe8-cb2cebcbf379" alt="Screenshot_4" width="300"/>
</p>
<p align="center">
    <img src="https://github.com/user-attachments/assets/b1e43da9-2a92-477f-899f-87d34da47ae5" alt="Screenshot_14" width="300"/>
  <img src="https://github.com/user-attachments/assets/6977cc2d-657e-4353-a09d-809de96c6215" alt="Screenshot_13" width="300"/>
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/4d379e2c-a052-46ea-bc1f-6daadcf0dc58" alt="Screenshot_9" width="300"/>
  <img src="https://github.com/user-attachments/assets/74d8e460-511c-4bb9-a59d-88d6cc5b6d5d" alt="Screenshot_10" width="300"/>
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/b9cd7e6e-0384-4422-b1e4-2d8b5c6d3e29" alt="Screenshot_11" width="300"/>
  <img src="https://github.com/user-attachments/assets/b447e1e2-156a-43db-97ce-963dc17b6705" alt="Screenshot_12" width="300"/>
</p>

## Getting Started

### 1. Add the Android Folder

If your project doesn't already include an `android` folder, you can generate it by running the following command in your main project directory:

```bash
flutter create .
```

### 2. Firebase Setup

To fully leverage Firebase features within your app, you’ll need to configure Firebase. Choose one of the following methods:

#### Option A: Add `firebase.json` File

1. Download the `firebase.json` configuration file from the Firebase Console.
2. Place the file in the root directory of your project.
3. Alternatively, you can use the Firebase CLI to configure Firebase.

#### Option B: Use Firebase Emulator

Set up the Firebase Emulator to simulate Firebase services locally:

1. Install the Firebase CLI if you haven't already:
   ```bash
   npm install -g firebase-tools
   ```

2. Initialize Firebase in your project:
   ```bash
   firebase init
   ```

3. Start the Firebase Emulator with Initial Data:
   ```bash
   firebase emulators:start --import=./emulator-data
   ```

### 3. OTP Verification and Notifications

![image](https://github.com/user-attachments/assets/272b99cb-efeb-4052-ba31-59bb4e23b340)
![image](https://github.com/user-attachments/assets/81ffa5c3-a239-40e8-9a89-5f15ef63054f)


This app integrates OTP verification and real-time notifications using Firebase Authentication and Firebase Functions. These features are also supported when running the app with Firebase Emulators.

#### OTP Verification:
- **Simulate OTP Verification**: With the Firebase Auth Emulator, you can test the OTP verification process without needing an actual phone number. This helps in testing the entire user authentication flow during development.

#### Notifications:
- **Real-time Notifications**: Firebase Functions, in conjunction with the Firebase Emulator, allow you to trigger notifications for various events (e.g., order status updates). This enables you to develop and test notification workflows without interacting with the live Firebase environment.


### 4. App Code Structure and Completed Features

The app's code structure follows a modular approach, with separate directories for different features and user flows. The following features have been implemented:

- **Home Screen**:
  - **Banners**: Display promotional banners at the top of the screen.
  - **Product Listings**: Showcase various products across different categories.
  - **Categories Listing**: Provide users with an easy way to browse products by categories.

- **Cart Flow**:
  - **Checkout**: Complete the checkout process with selected items.
  - **Address Selection**: Users can select or add a new address during checkout.
  - **Payment Method Selection**: Multiple payment methods are supported for a seamless checkout experience.

- **Past Orders**: View a history of past orders, allowing users to track their previous purchases.

- **Profile Section**: Manage user profile details, including personal information and settings.

- **Seller Section**: For users with a seller account, an additional section allows them to add or edit their products, enabling them to manage their listings directly within the app.
---

# Flutter Firebase E-Commerce Admin Panel

Welcome to the **Flutter Firebase E-Commerce Admin Panel**! This admin panel is designed to provide seamless control over the e-commerce platform, enabling administrators to manage products, sellers, coupons, banners, and more.

## Features Overview

### 1. Special Product Management
- **Upload Special Products**: Administrators can upload exclusive products directly from the admin panel. These products will be highlighted on the platform for special promotions or featured categories.

### 2. Seller Product Approval
- **Approve Seller Products**: Review and approve products submitted by sellers before they appear on the platform. This ensures quality control and adherence to platform guidelines.

### 3. Coupon and Banner Management
- **Add Coupons**: Create and manage discount coupons to offer special deals and promotions to customers.
- **Add Banners**: Upload and manage promotional banners that will be displayed throughout the app. Banners can be used to highlight special events, sales, or new arrivals.

### 4. App Management
- **Comprehensive Control**: The admin panel offers full control over various aspects of the app, allowing administrators to ensure the smooth operation of the platform.

### 5. Export Data as CSV
- **Admin CSV Export**: Easily export product, seller, or order data as CSV files for analysis or reporting purposes. This feature enables administrators to keep records and perform data-driven decisions.

## Approval Process Explanation

The approval process within the admin panel is critical for maintaining the quality and integrity of the e-commerce platform. When sellers submit new products, these products must first be reviewed by an administrator. Only after approval are the products listed on the platform for customers to purchase. This step ensures that all products meet the platform's standards, helping to maintain a high-quality shopping experience for users.

## Screenshots

Here's a visual overview of the admin panel features:

<p align="center">
  <img src="https://github.com/user-attachments/assets/c98f5c3f-144d-48a5-827d-31f78f34e2f6" alt="Admin Dashboard" width="600"/>
  <img src="https://github.com/user-attachments/assets/8cac231d-81d5-475b-8140-a5be247998c7" alt="Product Management" width="600"/>
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/aa4ee0d3-41ca-4f49-9b0e-63c8ad9acc95" alt="Seller Approvals" width="600"/>
  <img src="https://github.com/user-attachments/assets/e2d1c5ec-5221-4ceb-a3ac-533748e7c15d" alt="Coupon Management" width="600"/>
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/394fb2f3-d930-4d38-9c89-6274b4443137" alt="Banner Management" width="600"/>
  <img src="https://github.com/user-attachments/assets/5ea2e0ba-c193-4679-8e8b-642bd1af765f" alt="Data Export" width="600"/>
</p>

## Getting Started

### 1. Prerequisites

- Ensure that the main e-commerce app is set up and configured with Firebase.
- The admin panel should have the appropriate Firebase configurations (e.g., `firebase.json`) in place to interact with the backend.

### 2. Installation

1. Navigate to the project directory:
   ```bash
   cd admin_panel_directory
   ```

2. Install the required dependencies:
   ```bash
   flutter pub get
   ```

### 3. Running the Admin Panel

To start the admin panel, run the following command:

```bash
flutter run --web-renderer html
```

## Usage

- **Special Products**: Use the "Special Products" section to add new items that will be featured on the platform.
- **Seller Approvals**: Navigate to the "Seller Approvals" section

 to review and approve products submitted by third-party sellers.
- **Coupons and Banners**: Access the "Coupons" and "Banners" sections to create and manage promotional content.
- **Export as CSV**: In the admin panel, locate the export functionality to download relevant data as CSV files for offline analysis and reporting.

---

## Submission Details
- **Name**: Manan Kabra
- **College**: K.J. Somaiya College of Engineering
- **Email**: manan.kabra@somaiya.edu
- **Personal Email**: manankabra200318@gmail.com
- **Roll No**: 16010421041



