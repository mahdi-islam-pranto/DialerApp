import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'api/MyHttpOverrides.dart';
import 'dashboard/Dashboard.dart';

/*  LETEST DESIGN

  Activity name : Main activity
  Project name : iSalesCRM Mobile App
  Developer : Sk Nayeem Ur Rahman
  Designation : Senior Mobile App Developer at iHelpBD Dhaka, Bangladesh.
  Email : nayeemdeveloperbd@gmail.com phone : 01733364274
*/
//Launch Screen

/// new
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  navigatorKey;
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.light(),
      home: SplashScreen(),
    );
  }
}

// SplashScreen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loginStatus = false;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: animatedIconShow(),
      ),
    );
  }

//Show animated splash screen then redirect to UserLoginScreen
  animatedIconShow() {
    return AnimatedSplashScreen(
        splash: Image.asset("assets/images/logo.png"),
        splashTransition: SplashTransition.scaleTransition,
        duration: 3000,
        nextScreen: const DashboardScreen());
  }
}
