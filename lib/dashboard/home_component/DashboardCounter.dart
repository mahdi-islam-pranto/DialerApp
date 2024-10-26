import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../sip_account/SipDialPad.dart';

/*
  Activity name : DashboardCounter
  Project name : iSalesCRM Mobile Appb
  Description : This DashboardCounter provides the all activities total of CRM
*/

class DashboardCounter extends StatefulWidget {
  const DashboardCounter({Key? key}) : super(key: key);

  @override
  State<DashboardCounter> createState() => _DashboardCounterState();
}

class _DashboardCounterState extends State<DashboardCounter> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    internetCon();
  }

  var internetStatus = "";

  internetCon() async {
    InternetConnectionCheckerPlus.createInstance();
    // check internet connection
    InternetConnectionCheckerPlus();

    if (await InternetConnectionCheckerPlus().hasConnection) {
      setState(() {
        internetStatus = "Online";
      });
      print("Connected");
    } else {
      setState(() {
        internetStatus = "Offline";
      });
      print("Not Connected");
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

// internet connection
    var internet = "";

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blue,
              Colors.blue,
              Color(0xff85C1E9),
            ],
          ),
        ),
        child: Column(
          // internet instance

          // check internet connection

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.05),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "i",
                  style: TextStyle(
                      fontSize: screenWidth * 0.09,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  "Contact",
                  style: TextStyle(
                      fontSize: screenWidth * 0.07,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.02),
            // image
            Center(
              child: Image.asset(
                "assets/images/person.png",
                height: screenHeight * 0.1,
                fit: BoxFit.cover,
                color: Color.fromRGBO(210, 206, 206, 1.0),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            Text(
              "Welcome To ",
              style:
                  TextStyle(fontSize: screenWidth * 0.06, color: Colors.white),
            ),
            Image.asset(
              "assets/images/skrp.png",
              height: screenWidth * 0.1,
              width: screenWidth * 0.3,
              fit: BoxFit.fill,
            ),

            SizedBox(height: screenHeight * 0.4),

            // internet status text show
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Internet Status : ",
                  style: TextStyle(
                      fontSize: screenWidth * 0.04, color: Colors.white),
                ),
                Text(
                  internetStatus,
                  style: TextStyle(
                      fontSize: screenWidth * 0.04, color: Colors.black),
                ),
              ],
            ),

            // button
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            SipDialPad(phoneNumber: "", callerName: "unknown"),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                              position: offsetAnimation, child: child);
                        },
                        transitionDuration: Duration(milliseconds: 100),
                      ),
                    );
                  },
                  child: Container(
                    height: screenHeight * 0.25,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.9, color: Colors.blue),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(screenWidth * 0.1),
                        topRight: Radius.circular(screenWidth * 0.1),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Go to Contact",
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      SipDialPad(
                                          phoneNumber: "",
                                          callerName: "unknown"),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0);
                                    const end = Offset.zero;
                                    const curve = Curves.easeInOut;
                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation =
                                        animation.drive(tween);
                                    return SlideTransition(
                                        position: offsetAnimation,
                                        child: child);
                                  },
                                  transitionDuration:
                                      Duration(milliseconds: 100),
                                ),
                              );
                            },
                            icon: Icon(
                                size: 50, Icons.arrow_circle_right_rounded))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
