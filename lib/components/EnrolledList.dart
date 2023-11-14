import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:student_interface/HandleNetworking.dart';

class EnrolledList extends StatelessWidget {
  String id;
  String name;
  double attendance;

  EnrolledList(this.id, this.name, this.attendance);

  Future createAlertDialogue(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter code to mark attendance in $name:"),
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
        title: Text(id),
        subtitle: Text(name),
        trailing: CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 6.0,
          animation: true,
          percent: attendance,
          center: Text(
            (attendance * 100).toStringAsFixed(2) + "%",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Colors.black,
        ),
        onTap: () {
          createAlertDialogue(context).then((value) async {
            String enrollStatus = await HandleNetworking().attend(id, value);
            if (enrollStatus.toString() == "true") {
              SnackBar newSnackbar = SnackBar(
                content: Text("You Successfully marked Attendance for $name"),
                padding: EdgeInsets.only(bottom: 7.0, top: 7.0),
              );
              ScaffoldMessenger.of(context).showSnackBar(newSnackbar);
            } else if (value != null) {
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
  showSnackBar(String message){
     SnackBar snackBar = SnackBar(
      content: Text(message),
    );
  }
}
