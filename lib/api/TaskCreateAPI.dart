import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../progress_indicator/CustomProgressIndicator.dart';

class TaskCreateAPI {
  final BuildContext context;

  TaskCreateAPI(this.context);

  // Login method
  Future<void> sendDataToServer(
      String leadId,
      String startTime,
      String endTime,
      String assignTo,
      String taskOrTask,
      String followType,
      String note,
      String priority) async {
    CustomProgressIndicator customProgress = CustomProgressIndicator(context);

    try {
      customProgress.showDialog(
          "Please wait", SimpleFontelicoProgressDialogType.spinner);

      //Show progress dialog
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String token = sharedPreferences.getString("token").toString();

      //Api url
      String url = 'https://crm.ihelpbd.com/crm/api/crm/event-task-create.php';

      //Authentication
      Map<String, String> body = {
        "leadId": leadId,
        "start_time": startTime,
        "end_time": endTime,
        "assign": assignTo,
        "eventortask": taskOrTask,
        "note": note,
        "priority": priority
      };

      HttpClient httpClient = HttpClient();

      HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));

      // content type
      request.headers.set('content-type', 'application/json');
      request.headers.set('token', token);

      request.add(utf8.encode(json.encode(body)));

      //Get response
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();

      // Closed request
      httpClient.close();

      final data = jsonDecode(reply);

      //Check response code
      if (data["status"].toString().contains("200")) {
        //Hide progress
        customProgress.hideDialog();

        // ignore: use_build_context_synchronously
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Server message"),
            content: Text(data["data"], style: const TextStyle(fontSize: 16)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      } else {
        //Hide progress
        customProgress.hideDialog();
        // ignore: use_build_context_synchronously
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Server Error"),
            content:
                Text(data["data"], style: const TextStyle(color: Colors.red)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        );
        //Hide progress
        // customProgress.hideDialog();
      }
    } catch (e) {
      //Hide progress
      customProgress.hideDialog();

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Server Error"),
          content:
              Text(e.toString(), style: const TextStyle(color: Colors.red)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }
  }
}
