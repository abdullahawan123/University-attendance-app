import 'dart:core';
import 'package:flutter/material.dart';
import 'package:student_interface/HandleNetworking.dart';

class AvailableCourses extends StatelessWidget {
  String courseId;
  String courseIdName;
  String courseName;
  String adminId;
  int session;
  int sessionCount;
  bool enroll;

  AvailableCourses(this.courseId, this.courseName, this.adminId, this.session,
      this.sessionCount, this.enroll, this.courseIdName);

  Future createAlertDialogue(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter code for $courseName:"),
            content: TextField(
              controller: customController,
            ),
            actions: [
              MaterialButton(
                elevation: 5.0,
                child: Text("Submit"),
                onPressed: () {
                  Navigator.of(context).pop(customController.text.toString());
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.library_books),
        title: Text(courseIdName),
        subtitle: Text(courseName),
        onTap: () {
          createAlertDialogue(context).then((value) async {
            String enrollStatus =
                await HandleNetworking().enroll(courseId, value);
            if (enrollStatus.toString() == "true") {
              SnackBar newSnackbar = SnackBar(
                content: Text("You Successfully got enrolled in $courseName"),
                padding: EdgeInsets.only(bottom: 7.0, top: 7.0),
              );
              ScaffoldMessenger.of(context).showSnackBar(newSnackbar);
            } else if(value!=null){
              SnackBar newSnackbar = SnackBar(
                content: Text("Error: " + enrollStatus.toString()),
                padding: EdgeInsets.only(bottom: 7.0, top: 7.0),
              );
              ScaffoldMessenger.of(context).showSnackBar(newSnackbar);
            }
          });
        },
      ),
    );
  }
}

