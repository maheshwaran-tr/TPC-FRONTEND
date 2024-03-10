import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sit_placement_app/admin_pages/AdminChangePassword/AdminChangePassword.dart';
import 'package:sit_placement_app/admin_pages/AdminProfilePage/adminProfile.dart';
import 'package:sit_placement_app/admin_pages/drawer/drawer_home.dart';
import '../../../backend/models/staff_model.dart';
import '../../../backend/requests/auth_request.dart';
import '../../../home_page/home_page.dart';
import '../../../staff_pages/staff_profile_page/staff_profile.dart';

class AdminMenuPage extends StatefulWidget {

  final token;
  final int selectedIndex;
  final Staff staffProfile;

  const AdminMenuPage({Key? key,required this.token, required this.selectedIndex, required this.staffProfile}) : super(key: key);

  @override
  State<AdminMenuPage> createState() => _AdminMenuPageState();
}

class MenuOption {
  final IconData icon;
  final String title;

  MenuOption(this.icon, this.title);
}

class MenuOptions {
  static final home = MenuOption(Icons.home, "Home");
  static final profile = MenuOption(Icons.person, "Profile");
  static final changePass = MenuOption(Icons.lock_person, "Change Password");
  static final logout = MenuOption(Icons.logout, "Logout");

  static final allOptions = [home, profile, changePass, logout];
}

class _AdminMenuPageState extends State<AdminMenuPage> {
  int selectedIndex = 0; // Default to the Home page

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selectedIndex = widget.selectedIndex;
    });
  }// Default to the Home page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xE3FFFFE1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () {
                ZoomDrawer.of(context)!.close();
              },
              child: const Icon(
                Icons.close,
                color: Colors.black54,
                size: 30,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  // Add your user image here
                  // backgroundImage: AssetImage("assets/user_image.jpg"),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      "Hello,",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.staffProfile.staffName,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: ListView.builder(
                itemCount: MenuOptions.allOptions.length,
                itemBuilder: (BuildContext context, int index) {
                  final option = MenuOptions.allOptions[index];
                  return ListTile(
                    tileColor: index == selectedIndex ? Colors.lightBlueAccent.shade100 : null,
                    leading: Icon(
                      option.icon,
                      color: index == selectedIndex ? Colors.lightBlueAccent.shade100 : Colors.black,
                    ),
                    title: Text(
                      option.title,
                      style: TextStyle(
                        fontSize: 18,
                        color: index == selectedIndex ? Colors.lightBlueAccent.shade100 : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      handleMenuOptionTap(option, index);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> handleMenuOptionTap(MenuOption option, int index) async {
    setState(() {
      selectedIndex = index; // Update the selected index
    });

    if (option == MenuOptions.home) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminDrawerHome(token: widget.token),
        ),
      );

      // Add your logic for Home here
    } else if (option == MenuOptions.profile) {
      print('Tapped on Profile');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminProfilePage(token: widget.token),
        ),
      );
      // Add your logic for Profile here
    } else if (option == MenuOptions.changePass) {
      print('Tapped on Setting');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminChangePasswordPage(token: widget.token),
        ),
      );
      // Add your logic for Setting here
    } else if (option == MenuOptions.logout) {
      print('Tapped on Logout');
      await AuthRequest.logout(widget.token);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      print('Logout pressed');
      // Add your logic for Logout here
    }

    // Close the drawer after handling the tap
    ZoomDrawer.of(context)!.close();
  }
}