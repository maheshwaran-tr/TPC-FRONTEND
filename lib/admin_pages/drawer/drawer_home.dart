import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';


import '../../backend/models/staff_model.dart';
import '../../backend/requests/staff_request.dart';
import 'dashboard/dashboard.dart';
import 'menu_page/menu_page.dart';

class AdminDrawerHome extends StatefulWidget {

  final token;

  const AdminDrawerHome({ Key? key,required this.token }) : super(key: key);

  @override
  State<AdminDrawerHome> createState() => _AdminDrawerHomeState();
}

class _AdminDrawerHomeState extends State<AdminDrawerHome> {
  late Future<Staff> staffFuture;

  @override
  void initState() {
    super.initState();
    staffFuture = initializeStaff();
  }

  Future<Staff> initializeStaff() async {
    return StaffRequest.getStaffProfile(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Staff>(
          future: staffFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              Staff staffData = snapshot.data!;

              return ZoomDrawer(
                angle: 0.0,
                mainScreen: AdminDash(
                  token: widget.token,
                ),
                menuScreen: AdminMenuPage(
                  token: widget.token,
                  selectedIndex: 0,
                  staffProfile: staffData,
                ),
              );
            }
          }),
    );
  }
}
