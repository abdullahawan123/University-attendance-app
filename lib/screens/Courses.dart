import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:student_interface/HandleNetworking.dart';
import 'package:student_interface/components/AvailableCourses.dart';

class Courses extends StatefulWidget {
  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  void initState() {
    super.initState();
    getCoursesList();
  }

  late Future<List<AvailableCourses>> coursesList;
  Future<void> getCoursesList() async {
    HandleNetworking handleNetworking = HandleNetworking();
    coursesList = handleNetworking.getAvailableCourses();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[50],
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            elevation: 10,
            backgroundColor: Colors.blueAccent,
            title: Text(
              "Available Courses",
              style: TextStyle(fontSize: 25),
            ),
            toolbarHeight: 65,
          ),
          Container(
            height: MediaQuery.of(context).size.height * .8,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
                child: FutureBuilder<List<AvailableCourses>>(
              future: coursesList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return RefreshIndicator(
                    child: ListView(
                      children: snapshot.data!,
                    ),
                    onRefresh: getCoursesList,
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return Center(child: CircularProgressIndicator());
              },
            )),
          ),
        ],
      ),
    );
  }
}
