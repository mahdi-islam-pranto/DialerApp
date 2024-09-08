import 'package:flutter/material.dart';

import '../../sip_account/SipDialPad.dart';

/*
  Activity name : DashboardCounter
  Project name : iSalesCRM Mobile App
  Developer : Eng. Sk Nayeem Ur Rahman
  Designation : Senior Mobile App Developer at iHelpBD Dhaka, Bangladesh.
  Email : mazedulislam4970@gmail.com

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
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blue,
              Colors.blueAccent,
              Colors.redAccent,
            ],
          ),
        ),
        child: Column(
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
                      color: Colors.black,
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
                color: const Color.fromRGBO(210, 206, 206, 1.0),
              ),
            ),

            SizedBox(height: screenHeight * 0.5),
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
                            const SipDialPad(
                                phoneNumber: "", callerName: "unknown"),
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
                        transitionDuration: const Duration(milliseconds: 100),
                      ),
                    );
                  },
                  child: Container(
                    height: screenHeight * 0.25,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.9, color: Colors.black),
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
                          offset:
                              const Offset(0, 3), // changes position of shadow
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
                                      const SipDialPad(
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
                                      const Duration(milliseconds: 100),
                                ),
                              );
                            },
                            icon: const Icon(
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
