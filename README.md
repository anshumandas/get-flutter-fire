

# Flutter Firebase Goodies Shopping App

Welcome to the Flutter Firebase Goodies Shopping App! This app showcases an exciting e-commerce platform built using Flutter and Firebase, with multiple user flows: Guest, Buyer, Seller, and Admin. Follow the instructions below to set up the project and explore its features.

## Getting Started

### 1. Add the Android Folder



- **Generate the Android Folder in Your Existing Project**
  
 In your main project directory, you can directly create the `android` folder by running:
  ```bash
  flutter create .
  ```

### 2. Firebase Setup

To use Firebase features in your app, you need to configure Firebase by following one of these options:

1. **Add `firebase.json` file**: Download the `firebase.json` configuration file from the Firebase console and place it in the root directory of your project or Use Firebase Cli and configure accordingly.

2. **Use Firebase Emulator**: To set up the Firebase Emulator for local testing:

    - Install the Firebase CLI if you haven't already:
      ```bash
      npm install -g firebase-tools
      ```

    - Initialize Firebase in your project:
      ```bash
      firebase init
      ```

    - Start the Firebase Emulator:
      ```bash
      firebase emulators:start --import=./emulator-data
      ```

   - This must start the firebase emulator with such  visbile output:
<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/b31e2355-6628-415a-84fc-d6019940bf1e" style="width: 48%; height: 50%;" />
  <img src="https://github.com/user-attachments/assets/b054e7ce-a177-4605-9c05-6d0e83acb48e" style="width: 48%; height: 50%;" />
</div>




- **Test the App**: Open the app and interact with it to test different user flows while connected to the local emulator.
- Note: just make  sure to keep that particular port free or change the port number from firebase,json


The emulator allows you to simulate Firebase services locally, such as Firestore, Authentication, and more.

## User Flows

The app includes four distinct user flows:

1. **Guest**: Explore the app without logging in. Guests can browse products, view product details, and see limited features.
<div style="display: flex; align-items: center; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/104c86d4-1ded-4a53-b6e9-86c2ac2f1cfd" style="width: 22%; height: auto;" alt="Guest Flow Step 1" />
  <span style="font-size: 24px; margin: 0 8px;">➡️</span>
  <img src="https://github.com/user-attachments/assets/839c4004-8ba9-4afe-a217-398960a55912" style="width: 22%; height: auto;" alt="Guest Flow Step 2" />
  <span style="font-size: 24px; margin: 0 8px;">➡️</span>
  <img src="https://github.com/user-attachments/assets/53632926-196f-4fc1-9d54-a983a8d2b2dd" style="width: 22%; height: auto;" alt="Guest Flow Step 3" />
  <span style="font-size: 24px; margin: 0 8px;">➡️</span>
  <img src="https://github.com/user-attachments/assets/7405abb0-97ac-4ecd-8eb3-a0d604410a20" style="width: 22%; height: auto;" alt="Guest Flow Step 4" />
</div>








3. **Buyer**: Registered users who can add products to their cart, make purchases, and track orders.
Sure, here's how you can display the images in a Markdown format with three images in a row, along with proper text captions below each image:



### Result

| ![Enter Number](https://github.com/user-attachments/assets/5a7925c1-c41c-4627-9006-115b36cba4f8) | ![Save Address](https://github.com/user-attachments/assets/f3dab607-82b1-48a7-91b6-9e8e1df2a0b1) | ![Add Address](https://github.com/user-attachments/assets/ec0d40eb-2f2c-452d-b58f-518dca7671be) |
|:---:|:---:|:---:|
| **Enter Number** | **Enter Otp** | **Home Screen** |

| ![Multiple Addresses](https://github.com/user-attachments/assets/384205c5-3a2a-4c4a-b8b7-853d1d5d1fa7) | ![Checkout on Cart](https://github.com/user-attachments/assets/3b527eb7-4cfd-4279-b6b7-4e383517cd48) | ![Select Address on Cart](https://github.com/user-attachments/assets/3bb179f0-2d2b-4688-b9c1-2adae56ef477) |
|:---:|:---:|:---:|
| **Categories Screen** | **Products based on category** | **All Products** |

| ![Select Payment Method](https://github.com/user-attachments/assets/2ff0921c-e77a-4d48-8a16-4ba96ce0bdb4) | ![Order Confirm Screen](https://github.com/user-attachments/assets/b0d2f159-aa17-4f45-b755-c385536b1b29) | ![Order Placed Notification](https://github.com/user-attachments/assets/32af3f70-8687-443d-a149-1f1ceeac9251) |
|:---:|:---:|:---:|
| **Products added to cart** | **Product detail Page** | **Add address to go on cart** |

| ![Order Section](https://github.com/user-attachments/assets/c22a6e77-3a33-4232-bd18-8c248bdb4ede) | ![Profile Section](https://github.com/user-attachments/assets/05c906fb-58e3-4655-a186-b4edfee4aa11) | ![Account Details Section](https://github.com/user-attachments/assets/ba2f173c-3994-422b-b469-71fbd91bb229) |
|:---:|:---:|:---:|
| **Add address** | **Manage Address** | **Checkout Page** |

| ![Support Section](https://github.com/user-attachments/assets/898cb342-9a19-464c-8e93-59ba92b06a9a) | ![Past Queries](https://github.com/user-attachments/assets/95f9f48c-e88b-4538-b9e1-3c138e5f936c) | ![Search from Home](https://github.com/user-attachments/assets/515a4901-f998-4b52-889b-948f7c58607d) |
|:---:|:---:|:---:|
| **Select Address** | **Select Payment Mwthod** | **Order Confirm Screen** |


| ![Order Confirm Screen](https://github.com/user-attachments/assets/0ca3a516-e7f5-44d4-8c5d-d224075413ce) | ![Notification on Order Place](https://github.com/user-attachments/assets/65600110-6ffb-48f9-a7d8-7f70d844f8bf) | ![Order Section with Search and Filter Working](https://github.com/user-attachments/assets/3bb04557-98a1-49a4-9173-0a4bee2b7a53) |
|:---:|:---:|:---:|
| **Notification on Order Place** | **Order Section with Search and Filter Working** | **Order Section Example 1** |

| ![Order Section Example 1](https://github.com/user-attachments/assets/3457586f-6fe9-4ca1-89a5-7d27f40ab942) | ![Order Section Example 2](https://github.com/user-attachments/assets/f57aff96-1b9a-443b-a3d5-093c2c01f99e) | ![Profile Section](https://github.com/user-attachments/assets/88eb3632-7ecb-4dc6-be3f-e3677a38bcfe) |
|:---:|:---:|:---:|
| **Order Section Search** | **Profile Section** | **Account details edit** |
| ![Account Details Section](https://github.com/user-attachments/assets/507f8df1-1ea1-4a74-91fb-90b2abc37047) | ![Support Section](https://github.com/user-attachments/assets/d3c3f492-8ab5-401f-9c4d-af2e51fc7cb4) | ![Past Queries Section](https://github.com/user-attachments/assets/6e454140-52e0-4dcf-b119-e7617a57c9e1) |
|:---:|:---:|:---:|
| **Suport Section** | **Past Queries Section** | **Search for Home** |


5. **Seller**: Users who can list products for sale, manage inventory, and fulfill orders.

  

6. **Admin**: Admins have access to manage users, oversee transactions, and monitor app activities.

 



### Optional: Use Your Data or Start Fresh

To run the app with your data using the Firebase Emulator, or to set up a fresh Firebase project:

- **Option A: Use Emulator with Your Data**
  - If you have a pre-existing set of data you want to use, you can import it by running:
    ```bash
    firebase emulators:start --import=./emulator-data
    ```
  - Make sure your data files are in the `./emulator-data` directory to be loaded by the emulator.

- **Option B: Set Up a Fresh Firebase Project**
  - If you prefer to set up a fresh Firebase project:
    1. Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project.
    2. Add your desired Firebase services (Firestore, Authentication, etc.).
    3. Download the `google-services.json` file and place it in the `android/app` directory.
    4. Manually add initial data to your Firebase project using the Firebase Console.

## Screenshots

Include images of different screens and user flows to provide a visual overview of the app. Add screenshots to the `/images` folder and reference them accordingly in the README file.

## Contributing

If you want to contribute to this project, please fork the repository and submit a pull request. For any questions, feel free to open an issue.

## License

This project is licensed under the MIT License.

---

Feel free to adjust further or add more specific details as needed!
