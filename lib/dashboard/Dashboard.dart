//
// import 'dart:js';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:isalescrm/components/DrawMenu.dart';
// import 'package:isalescrm/dashboard/Home.dart';
// import 'package:isalescrm/sip_account/SIPConfiguration.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../database/StoreLeadContacts.dart';
// import '../task/AddTask.dart';
//
// /*
//   Activity name : Dashboard
//   Activity name : Dashboard
//   Project name : iSalesCRM Mobile App
//   Developer : Eng. M A Mazedul Islam
//   Designation : Senior Mobile App Developer at iHelpBD Dhaka, Bangladesh.
//   Email : mazedulislam4970@gmail.com
//   Description : This DashboardScreen provides the all functionalities and view
// */
//
// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({Key? key}) : super(key: key);
//
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   var currentScreenIndex = 1;
//
//   //DashboardScreen screen components
//   final dashboardScreenScreen = [
//     const AddTask(
//       isCallFromDashboard: true,
//     ),
//     const Home(),
//    // const LeadCreateForm()
//   ];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//
//     checkSipAccountStatus();
//     getAppPermissions();
//
//     StoreLeadContacts.fetch();
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: onBackPressed,
//       child: Scaffold(
//         appBar: AppBar(
//
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 colors: [
//                   Colors.blue,
//                   Colors.blue,
//                   Colors.blue,
//                 ],),
//             ),
//           ),
//
//           // backgroundColor:primaryColor,
//           // systemOverlayStyle:
//           //     const SystemUiOverlayStyle(statusBarColor: primaryColor),
//
//           //Search text field
//           // title: Row(
//           //   children: [
//           //     Image.asset(
//           //       "assets/images/logo.png",
//           //       width: 35,
//           //       height: 35,
//           //     ),
//           //     const Text(" Contact", style: TextStyle(letterSpacing: 1)),
//           //   ],
//           // ),
//           automaticallyImplyLeading: true,
//           // actions: [
//           //   // Notification button
//           //   IconButton(onPressed: () {
//           //     Get.bottomSheet(
//           //       Container(
//           //         decoration: BoxDecoration(
//           //             color: Colors.white,
//           //             borderRadius: BorderRadius.only(
//           //                 topRight: Radius.circular(15),
//           //                 topLeft: Radius.circular(15))),
//           //         height: 150,
//           //         child: Column(
//           //           children: [
//           //             ListTile(
//           //               title: Text('Light Theme'),
//           //               leading: Icon(Icons.light_mode),
//           //               onTap: () {
//           //                 Get.changeTheme(
//           //                   ThemeData.light(),
//           //                 );
//           //               },
//           //             ),
//           //             ListTile(
//           //               title: Text('Dark Theme'),
//           //               leading: Icon(Icons.dark_mode),
//           //               onTap: () {
//           //                 Get.changeTheme(ThemeData.dark());
//           //               },
//           //             ),
//           //           ],
//           //         ),
//           //       ),
//           //     );
//           //   }, icon: const Icon(Icons.dark_mode_outlined)),
//           //   // Sync button
//           //   const SizedBox(
//           //     width: 15,
//           //   )
//           // ],
//         ),
//
//         drawer: const DrawerMenu(),
//         //Bottom navigation
//         // bottomNavigationBar: BottomNavigationBar(
//         //   selectedFontSize: 15,
//         //   currentIndex: currentScreenIndex,
//         //   backgroundColor: bgColor,
//         //   //backgroundColor: Colors.deepPurple,
//         //   items: const [
//         //      BottomNavigationBarItem(icon: Icon(Icons.task), label: "Add Task"),
//         //      BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
//         //      BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined), label: "Add Lead"),
//         //   ]
//         //   ,onTap: (index){
//         //     setState(() {
//         //       currentScreenIndex = index;
//         //     });
//         //     },
//         // ),
//
//
//         // New Changed Buttom Navigation ( Nayeem developer .... 01733364274)
//
//         //
//         /// Bottom CurvedNavigation Bar
//         ///
//         // bottomNavigationBar: CurvedNavigationBar(
//         //     backgroundColor: Colors.white,
//         //     color: Colors.lightBlueAccent,
//         //
//         //     animationDuration: Duration(milliseconds: 300),
//         //     onTap: (index) {
//         //       //print(index);
//         //       setState(() {
//         //         currentScreenIndex = index;
//         //       });
//         //     },
//         //     items: const [
//         //
//         //       Icon(
//         //         Icons.task,
//         //         color: Colors.white,
//         //       ),
//         //       Icon(
//         //         Icons.home_outlined,
//         //         color: Colors.white,
//         //       ),
//         //       Icon(
//         //         Icons.list_alt_outlined,
//         //         color: Colors.white,
//         //       ),
//         //     ]),
//
//         body: dashboardScreenScreen[currentScreenIndex],
//       ),
//     );
//   }
//
//   // Back button alert
//   Future<bool> onBackPressed() async {
//     if (currentScreenIndex != 1) {
//       setState(() {
//         currentScreenIndex = 1;
//       });
//
//       return false;
//     }
//
//     return await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text('Are you sure?'),
//             content: const Text('Do you want to exit?.'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(false),
//                 child: const Text('No'),
//               ),
//               TextButton(
//                 onPressed: () => SystemNavigator.pop(),
//                 child: const Text('Yes'),
//               ),
//             ],
//           ),
//         ) ??
//          false;
//   }
// }
//
// void checkSipAccountStatus() async {
//   try {
//     var ref = await SharedPreferences.getInstance();
//
//     String? sipID = ref.getString("sipID");
//     String? sipDomain = ref.getString("sipDomain");
//     String? sipPassword = ref.getString("sipPassword");
//
//     SIPConfiguration.config(sipID!, sipDomain!, sipPassword!, true,);
//   } catch (e) {}
// }
//
// Future<void> getAppPermissions() async {
//   //microphone permission
//   if (!await Permission.microphone.status.isGranted) {
//     await Permission.microphone.request();
//   }
//
//   //phone permission
//   if (!await Permission.phone.status.isGranted) {
//     await Permission.phone.request();
//   }
//
//   //systemAlertWindow
//   if (!await Permission.systemAlertWindow.status.isGranted) {
//     await Permission.systemAlertWindow.request();
//   }
//
//   //storage
//   if (!await Permission.storage.status.isGranted) {
//     await Permission.storage.request();
//   }
//
//   //manageExternalStorage
//   if (!await Permission.manageExternalStorage.status.isGranted) {
//     await Permission.manageExternalStorage.request();
//   }
//
//   //ignoreBatteryOptimizations
//   if (!await Permission.ignoreBatteryOptimizations.status.isGranted) {
//     await Permission.ignoreBatteryOptimizations.request();
//   }
//
//   //contacts
//   if (!await Permission.contacts.status.isGranted) {
//     await Permission.contacts.request();
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/DrawMenu.dart';
import '../database/StoreLeadContacts.dart';
import '../sip_account/SIPConfiguration.dart';
import '../task/AddTask.dart';
import 'Home.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var currentScreenIndex = 1;

  // DashboardScreen screen components
  final dashboardScreenScreen = [
    const AddTask(
      isCallFromDashboard: true,
    ),
    const Home(),
    // const LeadCreateForm()
  ];

  @override
  void initState() {
    super.initState();

    checkSipAccountStatus();
    getAppPermissions();
    StoreLeadContacts.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.blue,
                  Colors.blue,
                  Colors.blue,
                ],
              ),
            ),
          ),
          automaticallyImplyLeading: true,
        ),
        drawer: const DrawerMenu(),
        body: dashboardScreenScreen[currentScreenIndex],
      ),
    );
  }

  // Back button alert
  Future<bool> onBackPressed() async {
    if (currentScreenIndex != 1) {
      setState(() {
        currentScreenIndex = 1;
      });
      return false;
    }

    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void checkSipAccountStatus() async {
    try {
      var ref = await SharedPreferences.getInstance();

      String? sipID = ref.getString("sipID");
      String? sipDomain = ref.getString("sipDomain");
      String? sipPassword = ref.getString("sipPassword");

      if (sipID != null && sipDomain != null && sipPassword != null) {
        SIPConfiguration.config(sipID, sipDomain, sipPassword, context);
        // SIPConfiguration.config(sipID, sipDomain, sipPassword, true, context);
      }
    } catch (e) {
      print("Error checking SIP account status: $e");
    }
  }

  Future<void> getAppPermissions() async {
    // Microphone permission
    if (!await Permission.microphone.isGranted) {
      await Permission.microphone.request();
    }

    // Phone permission
    if (!await Permission.phone.isGranted) {
      await Permission.phone.request();
    }

    // System alert window permission
    if (!await Permission.systemAlertWindow.isGranted) {
      await Permission.systemAlertWindow.request();
    }

    // Storage permission
    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
    }

    // Manage external storage permission
    if (!await Permission.manageExternalStorage.isGranted) {
      await Permission.manageExternalStorage.request();
    }

    // Ignore battery optimizations permission
    if (!await Permission.ignoreBatteryOptimizations.isGranted) {
      await Permission.ignoreBatteryOptimizations.request();
    }

    // Contacts permission
    if (!await Permission.contacts.isGranted) {
      await Permission.contacts.request();
    }
  }
}
