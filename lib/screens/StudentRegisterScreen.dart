import 'package:flutter/material.dart';
import 'package:student_interface/HandleNetworking.dart';
import 'package:student_interface/Models/FutureResponse.dart';
import 'package:student_interface/components/ReusableButton.dart';
import 'package:student_interface/screens/LoginScreen.dart';

class StudentRegisterScreen extends StatefulWidget {
  static const routeName = '/register';
  @override
  _StudentRegisterScreenState createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {
  final HandleNetworking handleNetworking = HandleNetworking();
  late String email;
  late String password;
  late String name;
  late int year;
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
                    name = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Name",
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
                    year = int.parse(value);
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Year of studying",
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
                    child: ReusableButton('Register'),
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
                          .registerStudent(email, name, password, year);
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
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName,
                              arguments: {
                                "msg":
                                "Verification email sent. First verify your email than login to AMS",
                              });
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
