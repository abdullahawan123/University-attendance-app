import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_interface/HandleNetworking.dart';
import 'package:student_interface/components/EnrolledList.dart';


class EnrolledCourses extends StatefulWidget {
  @override
  _EnrolledCoursesState createState() => _EnrolledCoursesState();
}

class _EnrolledCoursesState extends State<EnrolledCourses> {
  @override
  void initState() {
    super.initState();

    getId();
    getId().then((id) => {studentId = id, getCoursesList()});
    //getCoursesList();
  }

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id") ?? null;
    return id;
  }

  var studentId;

  late Future<List<EnrolledList>> enrolledList;
  Future<void> getCoursesList() async {
    HandleNetworking handleNetworking = HandleNetworking();
    print("aali bey $studentId");
    enrolledList = handleNetworking.getEnrolledCourses(studentId);
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
                "Enrolled Courses",
                style: TextStyle(fontSize: 25),
              ),
              toolbarHeight: 65,
            ),
            Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width,
              child: SafeArea(
                child: FutureBuilder<List<EnrolledList>>(
                  future: enrolledList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //if (snapshot.data.length != 0) {
                      print("not Empty ");

                      return RefreshIndicator(
                        child: ListView(
                          children: snapshot.data!,
                        ),
                        onRefresh: getCoursesList,
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "No Enrolled Courses!",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w300, // light
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      );
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ],
        ));
  }
}

// child: ListView.builder(
//               itemCount: 5,
//               padding: const EdgeInsets.all(8),
//               itemBuilder: (_, index) {
//                 return Padding(
//                   padding: EdgeInsets.all(8),
//                   child: Column(
//                     children: [
//                       Card(
//                         color: Colors.amber,
//                         elevation: 7,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(5))),
//                         child: Container(
//                           padding: EdgeInsets.all(50),
//                           height: 152,
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               }),
