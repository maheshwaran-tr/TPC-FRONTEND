import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lottie/lottie.dart';
import 'package:sit_placement_app/admin_pages/drawer/drawer_home.dart';
import 'package:sit_placement_app/staff_pages/drawer/drawer_home.dart';

import '../backend/requests/auth_request.dart';
import '../home_page/home_page.dart';
import '../student_pages/drawer/drawer_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _controller.addStatusListener((status) {
      print("COMPLETED");
      if (status == AnimationStatus.completed) {
        _checkTokenAndNavigate();
      }
    });
    _controller.forward();
  }

  _checkTokenAndNavigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedToken = prefs.getString('token');
    if (savedToken == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(savedToken);
      print("*******************************************");
      print(decodedToken);
      String role = decodedToken['role'];
      if (JwtDecoder.isExpired(savedToken)) {
        AuthRequest.logout(savedToken);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        print(savedToken);
        if (role == "STUDENT") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => StudentDrawerHome(token: savedToken)),
          );
        } else if (role == "STAFF") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => StaffDrawerHome(token: savedToken)),
          );
        } else if (role == "ADMIN") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AdminDrawerHome(token: savedToken)),
          );
        } else {
          print("NOTHING");
        }
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Lottie.asset(
              'assets/lottie/flow1.json',
              fit: BoxFit.fitWidth,
              controller: _controller,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
            ),
          ),
          Positioned(
            bottom: 140,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
