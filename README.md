Flutter-Fire E-commerce Boilerplate
This project provides a boilerplate for an e-commerce Flutter application integrating Firebase and GetX state management. It's designed to kickstart development of an online store with user authentication, product management, and a shopping cart system.
Technologies Used

Flutter 3.0 - For building the cross-platform e-commerce UI
GetX - State management and navigation
Firebase - Backend as a Service

Authentication
Cloud Firestore (for product and user data)
Cloud Functions



Features

User Authentication (Email/Password, Google OAuth, Anonymous)
User Roles (Buyer, Seller, Admin)
Product Catalog with Categories
Shopping Cart Functionality
User Profile Management
Firebase Emulator Integration for local development
Responsive design for mobile and web

E-commerce Specific Components

Product Listing: Displays products with details like name, price, and image
Shopping Cart: Allows users to add/remove items and proceed to checkout


Checkout Process: Simulated payment gateway integration

Setup Instructions

Fork this repository
Set up your Firebase project and run flutterfire configure to generate your firebase_options.dart file
Ensure you've set up the necessary Firebase services (Authentication, Firestore, Storage, Functions)
Run flutter pub get to install dependencies
Run the app using flutter run


Authentication Service: Handles user sign-up, login, and session management
Product Service: Manages product data and catalog operations
Cart Service: Handles shopping cart operations
User Profile Management: Allows users to update their profile information
Navigation: Implements GetX navigation for efficient routing
Remote Config: Demonstrates A/B testing capabilities for UI variations


Implement product search functionality
