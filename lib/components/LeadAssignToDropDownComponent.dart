import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


/*
  Component name : LeadAssignToDropDownComponent
  Project name : iSalesCRM Mobile App
  Developer : Eng. M A Mazedul Islam
  Designation : Senior Mobile App Developer at iHelpBD Dhaka, Bangladesh.
  Email : mazedulislam4970@gmail.com

  Description : This component provides the all lead assigner list id & name.
*/


class LeadAssignToDropDownComponent extends StatefulWidget {
  const LeadAssignToDropDownComponent({Key? key}) : super(key: key);

  @override
  State<LeadAssignToDropDownComponent> createState() => _LeadAssignToDropDownComponentState();
}

class _LeadAssignToDropDownComponentState extends State<LeadAssignToDropDownComponent>{


  bool isLeadAssignToLoading = false;
  List<String> leadAssignToID = [];
  List<String> leadAssignToName = [];
  String leadAssignToDropDownValue = "Select an assign person";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    //Call lead source api
    fetchLeadAssignToAPI();
  }

  @override
  Widget build(BuildContext context){

    try {

      if (leadAssignToName.contains(null) || leadAssignToID.contains(null) ||
          isLeadAssignToLoading) {
        return const Text("Not found");
      }


      var dropList = ["Select an assign person"];
      dropList.addAll(leadAssignToName);

      // return lead source in dropdown
      return Card(
        elevation: 2,
        child: DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            border: OutlineInputBorder(),
            labelText: "Assign to *",
          ),
          value: leadAssignToDropDownValue,
          onChanged: (String? newValue) {
            setState(() {
              leadAssignToDropDownValue = newValue!;
             // StaticVariable.assignTo = leadAssignToID[leadAssignToName.indexOf(leadAssignToDropDownValue)];
            });
          },

          items: dropList.map((String value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),

        ),
      );

    }catch(e){

      // if any exception occurs here then return this
      return const Text("Assign person not found");
    }
  }

  void fetchLeadAssignToAPI() async {

    setState(() {
      isLeadAssignToLoading = true;
    });

    //Show progress dialog
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    //Get user data from local device
    String token = sharedPreferences.getString("token").toString();

    // Api url
    String url = 'https://crm.ihelpbd.com/crm/api/crm/user_list.php';

    HttpClient httpClient = HttpClient();

    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));

    // content type
    request.headers.set('content-type', 'application/json');
    request.headers.set('token', token);

    //Get response
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();

    // Closed request
    httpClient.close();

    var data = json.decode(reply);

    if (data["status"].toString().contains("200")) {

      final items = json.decode(reply)["data"];

      setState(() {
        try {
          for (int index = 0; index < items.length; index++){

            leadAssignToID.add(items[index]["id"]);
            leadAssignToName.add(items[index]["user_name"]);

          }

          isLeadAssignToLoading = false;

        } catch (e) {
          isLeadAssignToLoading = true;
        }
      });
    } else {

      leadAssignToID = [];
      leadAssignToName = [];
      isLeadAssignToLoading = false;
    }
  }





}



