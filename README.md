# Chess Central

## Introduction

Hello! I'm Saubhagya Singh, a Flutter developer with a deep passion for chess. I was tasked with creating a Flutter app for the 1st round of Sharekhan, so I chose to go beyond conventional approaches and create something innovative. By leveraging the essence of the boilerplate code provided by Mr. Anshuman Das, I crafted a unique application.

In my previous projects, I utilized the traditional Model-View-Controller (MVC) file system. For this project, however, I embraced a more advanced architecture: Bindings-Views-Controllers (BVC). This sophisticated approach, along with a structured folder system for services and widgets, enables a cleaner and more efficient development process.

## Chess Central Overview

**Chess Central** is an app tailored for professional chess players, offering a range of features to enhance their chess experience. The app serves as a comprehensive solution with the following key functionalities:

1. **Live Chess Streamers on Twitch**:
   - Access and view your favorite chess streams directly within the app.

2. **Top 100 World-Level Players List**:
   - Stay updated with the list of the top 100 chess players globally, including their rankings and profiles.

3. **FIDE Search**:
   - Search for a player's FIDE ID to obtain detailed information about their game history and profile. For example, you can check my FIDE ID [25660586](https://www.fide.com/en/players/25660586) and Magnus Carlsen's FIDE ID [1503014](https://www.fide.com/en/players/1503014).

4. **Firebase Authentication**:
   - Secure user authentication using Firebase Auth to ensure a reliable and safe login experience.

5. **Google Sign-In Option**:
   - Sign in easily with your Google account for a seamless authentication process.

6. **Image Picker for Profile Updates**:
   - Use the image picker feature to update and customize your profile picture.

7. **Firestore Integration**:
   - Store and manage user data, including profile images, using Firestore for a scalable and real-time database solution.

## Development Insights

The development of Chess Central was completed within a tight timeframe, and there is ample room for future enhancements. Each step of the development process is meticulously documented through commit messages, allowing you to track the evolution of the project.

### Design and Assets

I have included the Excalidraw file, which contains the base design and wireframe of the app. Most of the images used in the app are Gemini-generated to avoid copyright issues, and the app's logo was designed using Canva.

### APIs Utilized

For real-time data integration, the following APIs have been used:
- [FIDE API](https://app.fide.com/api/docs): Provides access to FIDE-related data and player information.
- [Chess.com API](https://api.chess.com/pub/): Offers real-time chess data, including player profiles and game statistics.

A big thank you to the creators of these APIs for providing such valuable resources.

### Development Environment

This project was developed using the following tools and versions:

- **Flutter**: 3.24.1 • channel stable • [Flutter GitHub Repository](https://github.com/flutter/flutter.git)
  - Framework • revision 5874a72aa4 (11 days ago) • 2024-08-20 16:46:00 -0500
  - Engine • revision c9b9d5780d
  - Tools • Dart 3.5.1 • DevTools 2.37.2

- **Kotlin**: 1.7.10
- **Groovy**: 3.0.13
- **Ant**: Apache Ant(TM) version 1.10.11 compiled on July 10 2021
- **JVM**: 22.0.2 (Oracle Corporation 22.0.2+9-70)
- **OS**: Windows 11 10.0 amd64

### Stable Release APK

A stable release APK of the app has been added to the `stableapks` folder in this repository. You can download and install it to experience the app without needing to build it from source.
