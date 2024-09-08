///ager code but working fine
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:isalescrm/sip_account/CallUI.dart';
// import 'package:isalescrm/sip_account/SipAccountStatus.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:voip24h_sdk_mobile/callkit/model/sip_configuration.dart';
// import 'package:voip24h_sdk_mobile/callkit/utils/sip_event.dart';
// import 'package:voip24h_sdk_mobile/callkit/utils/transport_type.dart';
// import 'package:voip24h_sdk_mobile/voip24h_sdk_mobile.dart';
//
// class SIPConfiguration {
//
//   static void config(String sipID, String sipDomain, String sipPassword, bool status, BuildContext context) {
//     // SIP event handling
//
//     var sipConfiguration = SipConfigurationBuilder(
//       extension: sipID,
//       domain: sipDomain,
//       password: sipPassword,
//     )
//         .setKeepAlive(true)
//         .setPort(25067)
//         .setTransport(TransportType.Udp)
//         .build();
//
//     Voip24hSdkMobile.callModule.initSipModule(sipConfiguration);
//
//     Voip24hSdkMobile.callModule.eventStreamController.stream.listen((event) {
//       switch (event['event']) {
//         case SipEvent.AccountRegistrationStateChanged:
//           var body = event['body'];
//           print("call outbound : ${body}");
//           if (body["message"].toString().contains("Registration successful")) {
//             status = true;
//             SipAccountStatus.sipAccountStatus = true;
//             SipAccountStatus.extension = sipID;
//             storeSipCredential(sipID, sipDomain, sipPassword);
//           } else {
//             SipAccountStatus.sipAccountStatus = false;
//
//           }
//           break;
//
//         case SipEvent.Ring:
//           String? callerName = "Unknown";
//           String name;
//           if (callerName.toString().trim().isEmpty) {
//             name = "Unknown";
//           } else {
//             name = callerName.toString().trim();
//           }
//           var body = event['body'];
//           if (body['callType'] == "inbound") {
//             if (Platform.isAndroid) {
//               print("###################### Inbound Ring ##################");
//               _showInboundCallAlert(context,name,body['phoneNumber'].toString());
//             }
//           }
//           break;
//
//         default:
//           print("Unhandled event: ${event['event']}");
//           break;
//       }
//     });
//   }
//
//   static Future<void> storeSipCredential(String sipID, String sipDomain, String sipPassword) async {
//     var ref = await SharedPreferences.getInstance();
//     ref.setString("sipID", sipID);
//     ref.setString("sipDomain", sipDomain);
//     ref.setString("sipPassword", sipPassword);
//   }
//
//   static void _showInboundCallAlert(BuildContext context, callerName, String phoneNumber) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           title: Column(
//             children: [
//               // caller name + number
//
//               Row(
//                 children: [
//                   Icon(
//                     Icons.phone,
//                     color: Colors.green,
//                   ),
//                   SizedBox(width: 10),
//                   Text(
//                     callerName,
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 30),
//                 child: Row(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  children: [
//                    SizedBox(height: 5),
//                    Text(
//                      phoneNumber,
//                      style: TextStyle(fontSize: 15, color: Colors.blueGrey),
//                    ),
//                  ],
//                              ),
//               ),
//               // answer + Hangup button
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     icon: Icon(Icons.call),
//                     label: Text('Answer'),
//                     onPressed: () {
//                       answer();
//                       Navigator.push(context,MaterialPageRoute(builder: (context) => CallUI(callerName: callerName, phoneNumber: phoneNumber, )));
//
//                     },
//                   ),
//                   ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     icon: Icon(Icons.call_end),
//                     label: Text('Decline'),
//                     onPressed: () {
//                       reject();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ],
//
//           ),
//         );
//       },
//     );
//   }
//
//
// }
// // call recived
// void answer() {
//   Voip24hSdkMobile.callModule.answer().then((value) => {
//     print(value.toString())
//   }, onError: (error) => {
//     print(error)
//   });
// }
// // call hangup
// void reject() {
//   Voip24hSdkMobile.callModule.reject().then((value) => {
//     print(value)
//   }, onError: (error) => {
//     print(error)
//   });
// }

/// incoming call adding notification working good

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voip24h_sdk_mobile/callkit/model/sip_configuration.dart';
import 'package:voip24h_sdk_mobile/callkit/utils/sip_event.dart';
import 'package:voip24h_sdk_mobile/callkit/utils/transport_type.dart';
import 'package:voip24h_sdk_mobile/voip24h_sdk_mobile.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';
import 'CallUI.dart';
import 'SipAccountStatus.dart';
import 'SIPCredential.dart'; // Ensure this import

class SIPConfiguration {
  static final StreamController<String> _messageController =
      StreamController<String>.broadcast();
  static Stream<String> get messageStream => _messageController.stream;
  static void config(String sipID, String sipDomain, String sipPassword,
      BuildContext context) {
    var state = context.findAncestorStateOfType<SIPCredentialState>();

    // SIP event handling
    var sipConfiguration = SipConfigurationBuilder(
      extension: sipID,
      domain: sipDomain,
      password: sipPassword,
    ).setKeepAlive(true).setPort(25067).setTransport(TransportType.Udp).build();

    Voip24hSdkMobile.callModule.initSipModule(sipConfiguration);

    Voip24hSdkMobile.callModule.eventStreamController.stream.listen((event) {
      switch (event['event']) {
        case SipEvent.AccountRegistrationStateChanged:
          var body = event['body'];
          // server message
          var serverMsg = body["message"].toString();
          print("call outbound : ${body}");
          // pass message to strem
          _messageController.add(serverMsg);

          if (body["message"].toString().contains("Registration successful")) {
            SipAccountStatus.sipAccountStatus = true;
            SipAccountStatus.extension = sipID;
            storeSipCredential(sipID, sipDomain, sipPassword);
          } else {
            SipAccountStatus.sipAccountStatus = false;
            if (body["message"].toString().contains("Registration failed") ||
                body["message"].toString().contains("Forbidden")) {
              print("########################regi failed  " + serverMsg);
            }
          }
          break;

        case SipEvent.Ring:
          String? callerName = "Unknown";
          String name;
          if (callerName.toString().trim().isEmpty) {
            name = "Unknown";
          } else {
            name = callerName.toString().trim();
          }
          var body = event['body'];
          if (body['callType'] == "inbound") {
            if (Platform.isAndroid) {
              _showNotification(callerName, body['phoneNumber'].toString());
            }
          }
          break;

        default:
          print("Unhandled event: ${event['event']}");
          break;
      }
    });
  }

  static Future<void> storeSipCredential(
      String sipID, String sipDomain, String sipPassword) async {
    var ref = await SharedPreferences.getInstance();
    ref.setString("sipID", sipID);
    ref.setString("sipDomain", sipDomain);
    ref.setString("sipPassword", sipPassword);
  }

  static void _showInboundCallAlert(
      BuildContext context, String callerName, String phoneNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Column(
            children: [
              // caller name + number
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: Colors.green,
                  ),
                  SizedBox(width: 10),
                  Text(
                    callerName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      phoneNumber,
                      style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
              // answer + Hangup button
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Icon(Icons.call),
                    label: Text('Answer'),
                    onPressed: () {
                      answer();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CallUI(
                              callerName: callerName,
                              phoneNumber: phoneNumber,
                            ),
                          ));
                    },
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Icon(Icons.call_end),
                    label: Text('Decline'),
                    onPressed: () {
                      reject();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> _showNotification(
      String callerName, String phoneNumber) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'call_channel_id',
      'call_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Incoming Call',
      '$callerName is calling $phoneNumber',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  static void dispose() {
    _messageController.close();
  }
}

// Call received
void answer() {
  Voip24hSdkMobile.callModule.answer().then((value) {
    print(value.toString());
  }, onError: (error) {
    print(error);
  });
}

// Call hangup
void reject() {
  Voip24hSdkMobile.callModule.reject().then((value) {
    print(value);
  }, onError: (error) {
    print(error);
  });
}



/// Local notification adding but good working
//
// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:voip24h_sdk_mobile/callkit/model/sip_configuration.dart';
// import 'package:voip24h_sdk_mobile/callkit/utils/sip_event.dart';
// import 'package:voip24h_sdk_mobile/callkit/utils/transport_type.dart';
// import 'package:voip24h_sdk_mobile/voip24h_sdk_mobile.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import '../main.dart';
// import 'SipAccountStatus.dart';
// import 'CallUi.dart'; // Import your Call UI page here
//
// class SIPConfiguration {
//   static Timer? _notificationTimer;
//
//   static void config(String sipID, String sipDomain, String sipPassword, bool status, BuildContext context) {
//     var sipConfiguration = SipConfigurationBuilder(
//       extension: sipID,
//       domain: sipDomain,
//       password: sipPassword,
//     )
//         .setKeepAlive(true)
//         .setPort(25067)
//         .setTransport(TransportType.Udp)
//         .build();
//
//     Voip24hSdkMobile.callModule.initSipModule(sipConfiguration);
//
//     Voip24hSdkMobile.callModule.eventStreamController.stream.listen((event) {
//       // outgoing call
//       switch (event['event']) {
//         case SipEvent.AccountRegistrationStateChanged:
//           var body = event['body'];
//           print("call outbound : ${body}");
//           if (body["message"].toString().contains("Registration successful")) {
//             status = true;
//             SipAccountStatus.sipAccountStatus = true;
//             SipAccountStatus.extension = sipID;
//             storeSipCredential(sipID, sipDomain, sipPassword);
//           } else {
//             SipAccountStatus.sipAccountStatus = false;
//           }
//           break;
//          // incoming call
//         case SipEvent.Ring:
//           String? callerName = "Unknown";
//           String name;
//           if (callerName.toString().trim().isEmpty) {
//             name = "Unknown";
//           } else {
//             name = callerName.toString().trim();
//           }
//           var body = event['body'];
//           if (body['callType'] == "inbound") {
//             if (Platform.isAndroid) {
//               print("*******incoming call working********");
//               _showPersistentNotification(callerName, body['phoneNumber'].toString(), context);
//             }
//           }
//           break;
//
//         default:
//           print("Unhandled event: ${event['event']}");
//           break;
//       }
//     });
//   }
//
//   static Future<void> storeSipCredential(String sipID, String sipDomain, String sipPassword) async {
//     var ref = await SharedPreferences.getInstance();
//     ref.setString("sipID", sipID);
//     ref.setString("sipDomain", sipDomain);
//     ref.setString("sipPassword", sipPassword);
//   }
//
//   static Future<void> _showPersistentNotification(String callerName, String phoneNumber, BuildContext context) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'call_channel_id',
//       'Call Notifications',
//       channelDescription: 'Notifications for incoming calls',
//       importance: Importance.max,
//       priority: Priority.high,
//       ongoing: true,
//       autoCancel: false,
//       actions: <AndroidNotificationAction>[
//         AndroidNotificationAction(
//           'answer_action',
//           'Answer',
//         ),
//         AndroidNotificationAction(
//           'hangup_action',
//           'Hangup',
//         ),
//       ],
//     );
//
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     await flutterLocalNotificationsPlugin.show(
//        0,
//       'Incoming Call',
//       '$callerName is calling $phoneNumber',
//       platformChannelSpecifics,
//       payload: 'call_in_progress',
//     );
//
//     _startNotificationTimer();
//   }
//
//   static void initializeNotificationPlugin(BuildContext context) {
//     flutterLocalNotificationsPlugin.initialize(
//       const InitializationSettings(
//         android: AndroidInitializationSettings('app_icon'),
//       ),
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         if (response.actionId == 'answer_action') {
//           answerCall(context);
//         } else if (response.actionId == 'hangup_action') {
//           rejectCall(context);
//         }
//       },
//     );
//   }
//
//   static void _startNotificationTimer() {
//     _notificationTimer?.cancel();
//     _notificationTimer = Timer(Duration(minutes: 1), () {
//       _dismissNotification();
//     });
//   }
//
//   static void _dismissNotification() {
//     flutterLocalNotificationsPlugin.cancel(0);
//   }
//
//   static void answerCall(BuildContext context) {
//     _notificationTimer?.cancel();
//      answer();
//     _dismissNotification();
//
//     // Navigate to CallUi page
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => CallUI(phoneNumber: "phoneNumber", callerName: "callerName")), // Ensure CallUi is properly implemented
//     );
//   }
//
//   static void rejectCall(BuildContext context) {
//     _notificationTimer?.cancel();
//     reject();
//     _dismissNotification();
//   }
// }
//
// void answer() {
//   Voip24hSdkMobile.callModule.answer().then((value) {
//     print(value.toString());
//   }, onError: (error) {
//     print(error);
//   });
// }
//
// void reject() {
//   Voip24hSdkMobile.callModule.reject().then((value) {
//     print(value);
//   }, onError: (error) {
//     print(error);
//   });
// }
