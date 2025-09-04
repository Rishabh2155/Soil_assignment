# soil_health

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
Soil Health Monitoring App

Objective

This Flutter-based Android application connects to a Bluetooth-enabled device to retrieve soil temperature and moisture readings, stores the data in Firebase Firestore, and provides a clean UI to display both current and historical results.


Features

Bluetooth Device Communication

Scans and connects to a Bluetooth device (or a mock device).

Reads temperature (°C) and moisture (%) values.

Mock testing supported via Serial Bluetooth Terminal.

Firebase Integration

Uses Firebase Authentication (email/password) for login/signup.

Stores readings in Firestore with:

Timestamp

Temperature

Moisture

App UI

Login/Signup Screen → Secure authentication.

Home Screen →

Test button → Fetch a new reading.

Reports button → View the latest reading.

History Screen → Displays a list of past readings (with optional charts).


Tech Stack

Flutter (UI Framework)

Dart (Programming Language)

Firebase (Auth + Firestore Database)

flutter_blue_plus (Bluetooth communication)


Setup Instructions

1. Prerequisites

Flutter SDK installed (Guide
)

Android Studio (preferred) or VS Code

Firebase project with Authentication + Firestore enabled

2. Firebase Setup

Register the app in Firebase Console with package name:

com.example.soil_health


Download google-services.json → place it in:

android/app/google-services.json

3. Install Dependencies

Run the following in the project folder:

flutter pub get

4. Run the App
flutter run


The app will parse, display, and store this data in Firestore.

Example Firestore Document
{
  "timestamp": "2025-09-03T14:20:00Z",
  "temperature": 27,
  "moisture": 58
}

Assumptions

Mock Bluetooth testing is sufficient where hardware is unavailable.

Authentication flow is minimal (email/password only).

UI design prioritizes clarity over complexity.

Current version targets Android (iOS possible with extra setup).
