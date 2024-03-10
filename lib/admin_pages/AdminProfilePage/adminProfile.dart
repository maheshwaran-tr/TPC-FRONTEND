import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sit_placement_app/admin_pages/drawer/menu_page/menu_page.dart';
import 'package:sit_placement_app/staff_pages/drawer/menu_page/menu_page.dart';

import '../../backend/models/staff_model.dart';
import '../../backend/requests/staff_request.dart';


class AdminProfilePage extends StatefulWidget {
  final token;

  const AdminProfilePage({super.key, required this.token});

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  final _drawerController = ZoomDrawerController();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            _drawerController.toggle!();
          },
          icon: Icon(
            Icons.dashboard_customize_rounded,
            size: 30,
            color: Colors.black,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Center(child: Text('Profile',style: TextStyle(fontWeight: FontWeight.bold),)),
      ),
      extendBodyBehindAppBar: true,

      body: SafeArea(
        child: FutureBuilder<Staff>(
            future: staffFuture,
            builder: (context,snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                Staff staffData = snapshot.data!;
                return ZoomDrawer(
                  controller: _drawerController,
                  style: DrawerStyle.defaultStyle,
                  menuScreen: AdminMenuPage(token: widget.token,
                    selectedIndex: 1,
                    staffProfile: staffData,),
                  mainScreen: buildMainScreen(),
                  borderRadius: 25.0,
                  angle: 0,
                  // Adjust the angle for a more dynamic appearance
                  mainScreenScale: 0.2,
                  // Adjust the scale for the main screen
                  slideWidth: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                );
              }
            }
        ),
      ),
    );
  }
  Widget buildMainScreen() {
    return SingleChildScrollView(
      child: FutureBuilder<Staff>(
        future: staffFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Staff staffData = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.teal],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Center(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: AssetImage('assets/images/user.jpg'),
                                backgroundColor: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Text(
                                    staffData.staffName,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    staffData.department,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildProfileField('Staff ID', staffData.staffId, Icons.work),
                      buildProfileField('DOB', staffData.dob, Icons.calendar_today),
                      buildProfileField('Gender', staffData.gender, Icons.people),
                      buildProfileField('Email', staffData.email, Icons.email),
                      buildProfileField('Phone Number', staffData.phoneNumber, Icons.phone),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     appBar: AppBar(
  //       elevation: 0,
  //       backgroundColor: Colors.white,
  //       systemOverlayStyle: SystemUiOverlayStyle.dark,
  //       title: Center(
  //         child: Text(
  //           'Staff Profile',
  //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
  //         ),
  //
  //       ),
  //     ),
  //     body: SingleChildScrollView(
  //       child: FutureBuilder<Staff>(
  //         future: staffFuture,
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState == ConnectionState.waiting) {
  //             return Center(child: CircularProgressIndicator());
  //           } else if (snapshot.hasError) {
  //             return Center(child: Text('Error: ${snapshot.error}'));
  //           } else {
  //             Staff staffData = snapshot.data!;
  //
  //             return Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Container(
  //                   decoration: BoxDecoration(
  //                     gradient: LinearGradient(
  //                       colors: [Colors.blueAccent, Colors.teal],
  //                       begin: Alignment.topLeft,
  //                       end: Alignment.bottomRight,
  //                     ),
  //                     borderRadius: BorderRadius.circular(15),
  //                     border: Border.all(
  //                       color: Colors.white,
  //                       width: 2,
  //                     ),
  //                   ),
  //                   child: Column(
  //                     children: [
  //                       SizedBox(height: 20),
  //                       Center(
  //                         child: Column(
  //                           children: [
  //                             Container(
  //                               decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(60),
  //                                 boxShadow: [
  //                                   BoxShadow(
  //                                     color: Colors.grey.withOpacity(0.5),
  //                                     spreadRadius: 3,
  //                                     blurRadius: 7,
  //                                     offset: Offset(0, 3),
  //                                   ),
  //                                 ],
  //                               ),
  //                               child: CircleAvatar(
  //                                 radius: 60,
  //                                 backgroundImage: AssetImage('assets/images/user.jpg'),
  //                                 backgroundColor: Colors.white,
  //                               ),
  //                             ),
  //                             SizedBox(height: 10),
  //                             Padding(
  //                               padding: EdgeInsets.all(8),
  //                               child: Column(
  //                                 children: [
  //                                   Text(
  //                                     staffData.staffName,
  //                                     style: TextStyle(
  //                                       fontSize: 22,
  //                                       fontWeight: FontWeight.bold,
  //                                       color: Colors.white,
  //                                     ),
  //                                   ),
  //                                   Text(
  //                                     staffData.department,
  //                                     style: TextStyle(
  //                                       fontSize: 18,
  //                                       color: Colors.white,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       SizedBox(height: 20),
  //                     ],
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(16.0),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       buildProfileField('Staff ID', staffData.staffId, Icons.work),
  //                       buildProfileField('DOB', staffData.dob, Icons.calendar_today),
  //                       buildProfileField('Gender', staffData.gender, Icons.people),
  //                       buildProfileField('Email', staffData.email, Icons.email),
  //                       buildProfileField('Phone Number', staffData.phoneNumber, Icons.phone),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             );
  //           }
  //         },
  //       ),
  //     ),
  //   );
  // }

  Widget buildProfileField(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.blueAccent,
            size: 24,
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 6),
              Text(
                value,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}