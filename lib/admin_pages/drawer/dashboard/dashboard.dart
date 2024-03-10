
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sit_placement_app/admin_pages/AdminNotification/AdminNotification.dart';
import 'package:sit_placement_app/admin_pages/admin_home_page/add_staff.dart';
import 'package:sit_placement_app/admin_pages/admin_home_page/department_staff_list.dart';
import 'package:sit_placement_app/admin_pages/admin_home_page/department_student_list.dart';
import 'package:sit_placement_app/backend/requests/student_request.dart';
import '../../../backend/models/applied_job_model.dart';
import '../../../backend/models/staff_model.dart';
import '../../../backend/requests/staff_request.dart';
import '../../admin_home_page/job_applications.dart';
import '../../admin_home_page/jobs_list.dart';
import '../../admin_home_page/post_job.dart';
import '../../admin_home_page/posted_jobs.dart';
import '../menu_page/menu_page.dart';

class AdminDash extends StatefulWidget {

  final token;

  const AdminDash({Key? key,required this.token}) : super(key: key);

  @override
  State<AdminDash> createState() => _AdminDashState();
}

class _AdminDashState extends State<AdminDash> {


  late Future<Staff> staffFuture;
  final _drawerController = ZoomDrawerController();

  @override
  void initState() {

    super.initState();
    staffFuture = initializeStaff();
  }
  Future<Staff> initializeStaff() async {
    return StaffRequest.getStaffProfile(widget.token);
  }

  String _getGreeting() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  IconData _getIconForGreeting() {
    var hour = DateTime.now().hour;

    if (hour < 6) {
      return Icons.nightlight_round;
    } else if (hour < 12) {
      return Icons.wb_sunny;
    } else if (hour < 17) {
      return Icons.brightness_5;
    } else if (hour < 21) {
      return Icons.brightness_4;
    } else {
      return Icons.nightlight_round;
    }
  }

  List<Icon> catIcon = [
    Icon(Icons.assignment, color: Colors.white, size: 25,),
    Icon(Icons.assessment, color: Colors.white, size: 25,),
    Icon(Icons.plagiarism_sharp, color: Colors.white, size: 25,),
    Icon(Icons.assignment, color: Colors.white, size: 25,),
    Icon(Icons.assessment, color: Colors.white, size: 25,),

  ];

  List<Color> catColor = [
    Colors.tealAccent,
    Colors.amberAccent,
    Colors.redAccent,

    Colors.deepPurpleAccent,
    Colors.cyan,
  ];

  List catName = [
    "Dept Student List",
    "Post Job",
    "Add Staff",
    "Posted Job",
    "Staff List",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    selectedIndex: 0,
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
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Color(0xFFF2DF74),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _drawerController.toggle!();
                      },
                      child: Icon(Icons.dashboard_customize_rounded, size: 30, color: Colors.black54),
                    ),
                    GestureDetector(
                      onTap: () {
                        _navigateToNotifi();

                        print("Notification Icon Pressed");
                      },
                      child: Icon(Icons.notification_add_rounded, size: 30, color: Colors.blue),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(left: 3, right: 15),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    title: Text('Hello  !', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey,fontSize: 26)),
                    subtitle: Row(
                      children: [
                        Text(_getGreeting(), style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.blueGrey)),
                        SizedBox(width: 10,),
                        Icon(
                          _getIconForGreeting(),
                          // Get dynamic icon based on time
                          color: Colors.black,
                        ),
                      ],
                    ),
                    trailing: const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/user.jpg'),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: GridView.builder(
              itemCount: catName.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    if(catName[index] == "Add Staff"){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddStaffPage(token: widget.token,)),
                      );
                    }else if(catName[index] == "Dept Student List"){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DepartmentStudentListPage(token: widget.token,)),
                      );
                    }else if(catName[index] == "Post Job"){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JobPostingScreen(token: widget.token,)),
                      );
                    }else if(catName[index] == "Staff List"){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DepartmentStaffListPage(token: widget.token,)),
                      );
                    }else if(catName[index] == "Posted Job"){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PostedJobsListPage(token: widget.token,)),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: catColor[index],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: catIcon[index],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        catName[index], style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.7)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20,),
          Text("STUDENT STATUS ",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
          SizedBox(height: 40,),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 50,
                mainAxisSpacing: 10,
                children: [
                  itemDashboard('Job Applied List',
                      CupertinoIcons.rectangle_stack_person_crop_fill, Colors.blueGrey),
                  itemDashboard('Job Selected List',
                      CupertinoIcons.briefcase_fill, Colors.cyanAccent),
                  // Add more items as needed
                ],
              ),

            ),

          ),
          SizedBox(height: 30,),
        ],
      ),

    );
  }

  Widget itemDashboard(String title, IconData iconData, Color background) =>
      GestureDetector(
        onTap: () {
          print(title);
          _navigateToPage(title,widget.token,context);
        },
        child: Container(

          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    color: Theme.of(context).primaryColor.withOpacity(.1),
                    spreadRadius: 3,
                    blurRadius: 5)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: Colors.white)),
              const SizedBox(height: 8),
              Text(title.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium)
            ],
          ),
        ),
      );

  void _navigateToNotifi() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminNotificationsPage(),
      ),
    );
  }
}
Future<void> _navigateToPage(String pageTitle,String token,BuildContext context) async {
  switch (pageTitle) {
    case 'Job Applied List':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JobApplicationList(token: token,
          ),
        ),
      );
      break;
    case 'Job Selected List':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectedJobApplicationList(token: token,
          ),
        ),
      );
      break;
  }
}

Future<List<JobAppliedModel>?> getApprovedStudentsForAdmin(String token,int statusId) async {
  List<JobAppliedModel>? applications = await StudentRequest.getApprovedStudents(token, statusId);
  return applications;
}