import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_interface/HandleNetworking.dart';
import 'package:student_interface/Models/FutureResponse.dart';
import 'package:student_interface/components/ReusableButton.dart';
import 'package:student_interface/screens/StudentHomePage.dart';
import 'package:student_interface/screens/changePasswordScreen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  static var studentId;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final HandleNetworking handleNetworking = HandleNetworking();
  late String email;
  late String password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "images/logo.jpeg",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                TextField(
                  onChanged: (String value) {
                    email = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                TextField(
                  onChanged: (String value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Builder(builder: (BuildContext context) {
                  return GestureDetector(
                    child: ReusableButton('Login'),
                    onTap: () async {
                      if (password == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Invalid input"),
                        ));

                        return;
                      }

                      setState(() {
                        isLoading = true;
                      });

                      FutureResponse? result = await handleNetworking
                          .loginStudent(email, password);

                      setState(() {
                        isLoading = false;
                      });

                      if (result != null) {
                        if (result.err) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(result.msg),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(result.msg),
                          ));
                          saveValue("status", true, result.msg.toString());
                          LoginScreen.studentId = result.msg;
                          print("Logged In");
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              StudentHomePage.routeName,
                                  (Route<dynamic> route) => false);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "something went wrong please try again later"),
                        ));
                      }
                    },
                  );
                }),
                SizedBox(
                  height: 25.0,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen()),
                      );
                    },
                    child: Text(
                      'Forget Password',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 18.0),
                  child: Text(
                    'msg',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

saveValue(String key, bool value, String idValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("set $key as $value");
  prefs.setBool(key, value);
  prefs.setString("id", idValue);
}
