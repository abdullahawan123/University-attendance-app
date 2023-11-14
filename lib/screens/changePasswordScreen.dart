import 'package:flutter/material.dart';
import 'package:student_interface/HandleNetworking.dart';
import 'package:student_interface/Models/FutureResponse.dart';
import 'package:student_interface/components/ReusableButton.dart';



class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final HandleNetworking handleNetworking =  HandleNetworking();
  late String email;
  late String password;
  late String confirmPassword;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(20.0),
            //     topRight: Radius.circular(20.0),
            //   ),
            // ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 30.0),
                  child: Text(
                    'Change Password',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                TextField(
                  onChanged: (String value){
                    email = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Email",
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),

                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 30.0),
                  child: TextField(
                    onChanged: (String value){
                      password = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "New Password",
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                  child: TextField(
                    onChanged: (String value){
                      confirmPassword = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Re-Enter New Password",
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),

                    ),
                  ),
                ),
                Builder(
                    builder: (BuildContext context){
                      return GestureDetector(
                        child: ReusableButton('Change Password'),
                        onTap: () async{

                          if(password != confirmPassword)
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Invalid Input'),
                                ));

                            return;
                          }

                          setState(() {
                            isLoading = true;
                          });

                          FutureResponse? result = await handleNetworking.resetPassword(email, confirmPassword);

                          setState(() {
                            isLoading = false;
                          });

                          if(result != null)
                          {
                            if(result.err)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(result.msg),
                              ));
                            }
                            else
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(result.msg),
                                ),
                              );

                              Future.delayed(Duration(seconds: 2),(){
                                Navigator.pop(context);
                              });


                            }

                          }
                          else
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Invalid input"),
                              ),
                            );
                          }




                        },
                      );
                    }

                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
