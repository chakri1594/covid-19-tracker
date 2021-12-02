import 'package:covid_19_tracker/view/symptoms/symptoms_page.dart';
import 'package:covid_19_tracker/model/home_screen.dart';
import 'package:covid_19_tracker/view/screens/virus_details_page.dart';
import 'package:covid_19_tracker/view/selfassessment/qna.dart';
import 'package:flutter/material.dart';
import 'package:covid_19_tracker/view/onboard/onboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:covid_19_tracker/view/screens/routes.dart';

import '/view/precaution/precaution_page.dart';



String initialScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding().addPostFrameCallback((timeStamp) {});

  initialScreen =
  await isFrstTimeUser() ? Routes.Onboard : Routes.HomeScreen;
  print('InitialScreen : $initialScreen');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    isFrstTimeUser();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialScreen,
      routes: <String, WidgetBuilder>{
        Routes.Onboard: (context) => Onboard(),
        Routes.HomeScreen: (context) => HomeScreen(),
        Routes.QNA: (context) => QNA(),
        Routes.Precaution: (context) => Precaution(),
        Routes.Symptoms: (context) => Symptoms(),
        Routes.FAQ: (context) => VirusDetailsScreen(),
      },
    );
  }
}

Future<bool> isFrstTimeUser() async {
  SharedPreferences _sharedPreferences;
  bool isFirstTimeUser;
  _sharedPreferences = await SharedPreferences.getInstance();
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
