import 'package:flutter/material.dart';
import 'package:student_interface/screens/LoginScreen.dart';
import 'package:student_interface/screens/StudentHomePage.dart';
import 'package:student_interface/screens/StudentRegisterScreen.dart';
import 'package:student_interface/screens/WelcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

//void main() => runApp(MyApp());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool status = prefs.getBool('status') ?? false;
  print(status);

  runApp(MyApp(status));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool getStatus;

  MyApp(this.getStatus);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AMS',

      //home: WelcomeScreen(),
      initialRoute: getStatus == false ? '/' : StudentHomePage.routeName,
      routes: {
        '/': (context) => WelcomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        StudentRegisterScreen.routeName: (context) => StudentRegisterScreen(),
        StudentHomePage.routeName: (context) => StudentHomePage(),
      },
    );
  }
}
