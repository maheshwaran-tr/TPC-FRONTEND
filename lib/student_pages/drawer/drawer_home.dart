// Inside the 'student_drawer_home.dart' file

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sit_placement_app/backend/models/student_model.dart';

import 'package:sit_placement_app/data_initializer/data_initializer.dart';
import 'package:sit_placement_app/student_pages/drawer/dashboard/dashboard.dart';
import 'menu_page/menu_page.dart';

class StudentDrawerHome extends StatefulWidget {
  final token;

  const StudentDrawerHome({Key? key, required this.token}) : super(key: key);

  @override
  State<StudentDrawerHome> createState() => _StudentDrawerHomeState();
}

class _StudentDrawerHomeState extends State<StudentDrawerHome> {
  late final Future<Student> studentProfile;

  @override
  void initState() {
    super.initState();
    studentProfile = Initializer.initializeStudents(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder(
        future: studentProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the future is complete, pass the Student object to DashBoard
            return ZoomDrawer(
              angle: 0.0,
              mainScreen: DashBoard(
                token: widget.token,
                student: snapshot.data
              ),
              menuScreen: MenuPage(token: widget.token, selectedIndex: 0,),
            );
          } else {
            // If the future is not complete, show a loading indicator or handle accordingly
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
