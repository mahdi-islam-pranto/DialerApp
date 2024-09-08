import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


/*
  Component name : LeadAssociatePersonDropDownComponent
  Project name : iSalesCRM Mobile App
  Developer : Eng. M A Mazedul Islam
  Designation : Senior Mobile App Developer at iHelpBD Dhaka, Bangladesh.
  Email : mazedulislam4970@gmail.com

  Description : This component provides the associate dropdown.
*/


class LeadAssociatePersonDropDownComponent extends StatefulWidget {
  const LeadAssociatePersonDropDownComponent({Key? key}) : super(key: key);

  @override
  State<LeadAssociatePersonDropDownComponent> createState() => _LeadAssociatePersonDropDownComponentState();
}

class _LeadAssociatePersonDropDownComponentState extends State<LeadAssociatePersonDropDownComponent>{
 // AssociatePerson

  bool isLeadAssociatePersonLoading = false;
  List<String> leadAssociatePersonID = [];
  List<String> leadAssociatePersonName = [];
  String leadAssociatePersonDropDownValue = "Select an associate person";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    //Call associate person api
    fetchAssociatePersonAPI();
  }

  @override
  Widget build(BuildContext context){

    try {

      if (leadAssociatePersonName.contains(null) || leadAssociatePersonID.contains(null) ||
          isLeadAssociatePersonLoading) {
        return const Text("Associate person not found");
      }


      var dropList = ["Select an associate person"];
      dropList.addAll(leadAssociatePersonName);

      // return lead source in dropdown
      return Card(
        elevation: 2,
        child: DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            border: OutlineInputBorder(),
            labelText: "Associate person ",
          ),
          value: leadAssociatePersonDropDownValue,
          onChanged: (String? newValue) {
            setState(() {
              leadAssociatePersonDropDownValue = newValue!;
              //StaticVariable.associatePerson = leadAssociatePersonID[leadAssociatePersonName.indexOf(leadAssociatePersonDropDownValue)];
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
      return const Text("Not found");
    }
  }

  void fetchAssociatePersonAPI() async {

    setState(() {
      isLeadAssociatePersonLoading = true;
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

            leadAssociatePersonID.add(items[index]["id"]);
            leadAssociatePersonName.add(items[index]["user_name"]);

          }
          isLeadAssociatePersonLoading = false;

        } catch (e) {
          isLeadAssociatePersonLoading = true;
        }
      });
    } else {

      leadAssociatePersonID = [];
      leadAssociatePersonName = [];
      isLeadAssociatePersonLoading = false;
    }
  }





}



