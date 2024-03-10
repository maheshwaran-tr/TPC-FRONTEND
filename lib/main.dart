import 'package:flutter/material.dart';
import 'package:sit_placement_app/splash_screen/splash_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}