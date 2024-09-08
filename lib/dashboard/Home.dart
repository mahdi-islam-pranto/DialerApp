import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_component/DashboardCounter.dart';


/*
  Activity name : Home
  Project name : iSalesCRM Mobile App
  Developer : Eng. M A Mazedul Islam
  Designation : Senior Mobile App Developer at iHelpBD Dhaka, Bangladesh.
  Email : mazedulislam4970@gmail.com
  Description : This Home screen provides the all dashboard components view
*/

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController callNumber = TextEditingController();
  String callingStatus = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: ListView(

        children: [

          //Dashboard counter
          Container(
            height: 650.h,
            decoration : BoxDecoration(borderRadius: BorderRadius.circular(10),),


             // Dashbord home screen
            // New Changed (Nayeem developer.....01733364274)
            child: const DashboardCounter(),
          )

        ],

      )
    );
  }
}