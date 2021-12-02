# covid_19_tracker

A mobile app for iOS and Android designed using Flutter for tracking COVID-19 cases around the globe

what left

API integration
splash screen
notification/
assessment

for onboarding to work only once make it "false" in main.dart

if (_sharedPreferences.getBool('first_time_user') == null) {
await _sharedPreferences.setBool('first_time_user', true);
isFirstTimeUser = true;
print('First Time User!!');
} else {
isFirstTimeUser = false;
print('Not a First Time User');
}
return isFirstTimeUser;
}

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


#Instructions for setting up project in your system

Step 1: Download the code zip file from GitHub

Step 2: Extract the zip file and open the project in Android Studio

PS: Make sure you have Flutter installed in system and the path of Flutter set to global PATH variable. Also, download all the required SDKS and AVDs in Android Studio to run the emulator

Step 3: After opening the project in Android Studio, head over to the pubspec.yaml file and look for 'pug get' keyword on top right. 

Executing pub get will install all the dependencies of the project in your system. 

Step 4: After getting the dependencies, run the main.dart file by first opening the emulator. 

Please follow these steps to set up the project in your system. 