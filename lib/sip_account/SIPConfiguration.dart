import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:voip24h_sdk_mobile/callkit/model/sip_configuration.dart';
import 'package:voip24h_sdk_mobile/callkit/utils/sip_event.dart';
import 'package:voip24h_sdk_mobile/callkit/utils/transport_type.dart';
import 'package:voip24h_sdk_mobile/voip24h_sdk_mobile.dart';

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
              _showInboundCallAlert(
                  context, name, body['phoneNumber'].toString());
              // _showNotification(callerName, body['phoneNumber'].toString());
              print(
                  "###################### Inbound/incoming call Received & Ring ##################");
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
                  const Icon(
                    Icons.phone,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    callerName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      phoneNumber,
                      style:
                          const TextStyle(fontSize: 15, color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
              // answer + Hangup button
              const SizedBox(height: 20),
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
                    icon: const Icon(Icons.call),
                    label: const Text('Answer'),
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
                    icon: const Icon(Icons.call_end),
                    label: const Text('Decline'),
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
