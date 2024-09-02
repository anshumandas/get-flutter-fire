## Sharekhan Qualification Project (README.md)

**Welcome!** This repository holds the code for my Sharekhan qualification project, built using Flutter 3.0. 

This README provides an overview of:

* Technologies used
* Key features implemented
* Setup and running instructions
* My contributions

**Technologies Used:**

* **Flutter 3.0:** A powerful toolkit for building beautiful native apps for mobile, web, and desktop from a single codebase using Dart.
* **GetX:** A comprehensive state management solution for Flutter, providing reactive programming, route management, and dependency injection.
* **Firebase:** A suite of cloud-based tools for building and managing applications, including authentication, cloud functions, and real-time databases. 

**Key Features:**

1. **Firebase Initialization:**
  - Configured for macOS, iOS, and web platforms (lib/main.dart).
  - Ensures Firebase services are accessible throughout the app.
2. **New Features:**
    * **Change Password Screen:** (lib/screens/auth/change_password_screen.dart)
        - Manages changing user passwords with GetX for reactive UI updates.
    * **ReCaptcha Integration for Web:** (lib/controllers/recaptcha_controller.dart)
        - Simulates ReCaptcha verification (actual API integration required).
    * **Email Verification for Password Reset:** (lib/controllers/reset_password_controller.dart)
        - Manages password reset with email verification and GetX notifications.
    * **Phone Authentication and 2FA with SMS Pin:** (lib/controllers/auth_controller.dart)
        - Handles phone authentication and two-factor authentication (2FA) with SMS.
    * **Large vs Small Screen Responsiveness:** (lib/screens/responsive_layout.dart)
        - ResponsiveLayout widget adapts the UI based on screen size for optimal user experience.
3. **Modified Existing Files:**
    * **Login Screen:** (lib/screens/auth/login_screen.dart)
        - Updated to integrate ReCaptcha verification with dynamic UI updates via GetX.
    * **Reset Password Screen:** (lib/screens/auth/reset_password_screen.dart)
        - Provides UI with fields, buttons, and GetX-based state management.
    * **Phone Authentication Screen:** (lib/screens/auth/phone_auth_screen.dart)
        - Added UI for phone number and SMS code with GetX for updates and notifications.
    * **Custom Claims for User Roles:** (lib/services/role_service.dart)
        - RoleService class interacts with Firebase Cloud Functions to set user roles.
    * **Role Management Screen:** (lib/screens/admin/role_management_screen.dart)
        - UI for managing roles with RoleService for updates and GetX notifications.
    * **Theming and Responsiveness:** (lib/main.dart)
        - Sets up theming (light/dark) and responsive HomeScreen for different devices.

**How to Run:**

1. Install dependencies: `flutter pub get`
2. Setup Firebase: Add configuration files to `android/app/` and `ios/Runner/`.
3. Run the app: `flutter run` on your device or emulator.

**About My Contributions:**

This project marks my initial venture into Flutter and mobile development. Having expertise in Python's AI and Machine Learning, transitioning to mobile development has been a challenging yet rewarding experience. I'm eager to further develop my skills in this area.

**Contact:**

* Name: Parth Dhabalia
* PRN: 1032211410
* College: MIT WPU, PUNE
* Email: parthdhabalia07@gmail.com
* Phone: 9518339401