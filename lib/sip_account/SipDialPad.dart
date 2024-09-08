/// 9/05/2024 old design good workign
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
// import 'package:isalescrm/constants/Constants.dart';
// import 'package:isalescrm/dashboard/Dashboard.dart';
// import 'package:isalescrm/sip_account/CallUI.dart';
// import 'package:isalescrm/sip_account/call_logs/CallLogsModel.dart';
// import 'package:isalescrm/sip_account/SipAccountStatus.dart';
// import 'package:marquee/marquee.dart';
//
// import '../contacts/ContactsDetails.dart';
// import 'call_logs/CallLogDetails.dart';
// import '../database/DBHandler.dart';
//
// class SipDialPad extends StatefulWidget {
//
//   const SipDialPad({Key? key, required this.phoneNumber, required this.callerName}) : super(key: key);
//
//   final String phoneNumber;
//   final String callerName;
//
//   @override
//   State<SipDialPad> createState() => _SipDialPadState();
// }
//
//     class _SipDialPadState extends State<SipDialPad> {
//
//       TextEditingController digitsController = TextEditingController();
//       List<String> numberDigits = [];
//       int cursorCurrentIndex = 0;
//
//       bool isDialPadShowing = false;
//       String? callerName;
//
//
//       /*
//       false = history search
//       true = contacts search
//        */
//   bool isSearch = false;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     callerName = widget.callerName;
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     digitsController.clear();
//     numberDigits.clear();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.phoneNumber.isNotEmpty) {
//       for (int i = 0; i < widget.phoneNumber.length; i++) {
//         numberDigits.add(widget.phoneNumber[i]);
//         setDigitInList();
//       }
//     }
//
//
//     return DefaultTabController(
//
//       length: 2,
//       child: WillPopScope(
//         onWillPop: onBackPressed,
//         child: Scaffold(
//
//             appBar: AppBar(
//               // New Changed
//
//               flexibleSpace: Container(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                       colors: [       Colors.blueAccent,
//                         Colors.blueAccent,
//                         Colors.redAccent,]),
//                 ),
//               ),
//
//               // backgroundColor: Color.fromRGBO(225, 217, 221, 1.0),
//               // systemOverlayStyle: const SystemUiOverlayStyle(
//               //     statusBarColor:Color.fromRGBO(225, 217, 221, 1.0), ),
//               centerTitle: true,
//               //Search text field
//               title: Container(
//                   height: 35,
//                   padding: const EdgeInsets.only(left: 0, right: 2),
//                   decoration: BoxDecoration(color: Colors.white70,
//                       borderRadius: BorderRadius.circular(5)),
//                   child: searchContacts()),
//
//                actions: [
//                 // Searching button
//
//                 //SIP Account active indicator
//                 SipAccountStatus.sipAccountStatus ?
//
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 15,
//                       height: 15,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         color: const Color.fromRGBO(0, 255, 0, 1),
//                       ),
//
//                     ),
//                     SizedBox(
//                         width: 40,
//                         height: 15,
//                         child: Marquee(
//                           text: SipAccountStatus.extension,
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                           scrollAxis: Axis.horizontal,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           blankSpace: 10.0,
//                           velocity: 50.0,
//                           textDirection: TextDirection.ltr,
//                           pauseAfterRound: const Duration(seconds: 1),
//                           accelerationDuration: const Duration(seconds: 0),
//                           accelerationCurve: Curves.easeInCirc,
//                           decelerationDuration: const Duration(
//                               milliseconds: 500),
//                           decelerationCurve: Curves.easeInCirc,
//                         )
//                     ),
//                   ],
//
//                 ) : Center(
//                   child: Container(
//                     width: 20,
//                     height: 20,
//                     margin: const EdgeInsets.only(right: 10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: const Color.fromRGBO(100, 100, 100, 01),
//                     ),
//
//                   ),
//                 ),
//
//                 const SizedBox(width: 10)
//
//               ],
//             ),
//
//             floatingActionButton: Visibility(
//               visible: !isDialPadShowing,
//
//               child: FloatingActionButton(
//
//                 child: Container(
//                   width: 60,
//                   height: 60,
//                   child: const Icon(Icons.dialpad,size: 30),
//                   decoration: BoxDecoration(
//
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       colors: [
//                         Colors.blueAccent,
//                         Colors.blueAccent,
//                         Colors.redAccent,
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(20),
//
//                                 ),
//                 ),
//
//                 // Mzed Vai
//               //  backgroundColor: Colors.deepPurpleAccent.shade400,
//               //  foregroundColor: Colors.white,
//                 onPressed: () {
//                   setState(() {
//                     //set
//                     if (isDialPadShowing) {
//                       isDialPadShowing = false;
//                     } else if (!isDialPadShowing) {
//                       isDialPadShowing = true;
//                     }
//                   });
//                 },
//                // child: const Icon(Icons.dialpad, size: 30),
//               ),
//             ),
//
//             body: Column(
//               children: [
//
//                 //Call logs and Contacts tap
//                 const TabBar(
//                     labelColor: primaryColor,
//                     unselectedLabelColor: Colors.grey,
//                     tabs: [
//                       Tab(
//                         icon: Icon(Icons.history),
//                         text: "History",
//                       ),
//                       Tab(
//                         icon: Icon(Icons.people_alt_outlined),
//                         text: "Contacts",
//                       ),
//                     ]
//                 ),
//
//                 const SizedBox(height: 5),
//
//                 //Tab pages
//                 Expanded(
//                   child: TabBarView(
//                       children: [
//                         //Display call logs
//                         getCallLogs(),
//                         //Display Phone contacts
//                         getContactsTabView(),
//                       ]
//                   ),
//                 ),
//
//                 //DialPab
//              getDialPad()
//                 //DialPadPopupScreen()
//               ],
//             )
//
//
//         ),
//       ),
//     );
//   }
//
//
//   // Back button alert
//   Future<bool> onBackPressed() async {
//     if (isDialPadShowing) {
//       setState(() {
//         isDialPadShowing = false;
//       });
//       return false;
//     }
//     return true;
//   }
//
//
//
//
//
//       Widget getDialPad() {
//         return Visibility(
//
//           visible: isDialPadShowing,
//           child: Container(
//
//             color: Color.fromRGBO(239, 229, 229, 0.9568627450980393),
//             padding: const EdgeInsets.all(10),
//
//             child: Column(
//
//                 children: [
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//
//                         IconButton(onPressed: (){
//
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(builder: (context) => DashboardScreen()),
//                           );
//                         }, icon: Icon(Icons.arrow_back)),
//                       ]
//                   ),
//                   //phone number field
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//
//                         Flexible(
//                           flex: 10,
//                           child: TextField(
//                             autofocus: true,
//                             toolbarOptions: const ToolbarOptions(
//                               copy: true,
//                               cut: true,
//                               selectAll: true,
//                               paste: true,
//                             ),
//                             controller: digitsController,
//                             keyboardType: TextInputType.none,
//                             textAlign: TextAlign.center,
//                             maxLines: 1,
//                             decoration: const InputDecoration(
//                                 border: InputBorder.none
//                             ),
//                             style: const TextStyle(
//                                 fontSize: 35, color: Colors.black),
//                             onTap: () {
//                               cursorCurrentIndex = digitsController.selection.base.offset;
//                             },
//
//                           ),
//                         ),
//                         Flexible(
//                             flex: 2,
//                             child: TextButton(
//                               child: const Icon(Icons.cancel, size: 30,color: Colors.grey,),
//                               onPressed: () {
//                                 try {
//                                   //remove digit one by one from dial pad
//                                   numberDigits.removeAt(cursorCurrentIndex - 1);
//                                   removeDigitFromList();
//                                 } catch (e) {}
//                               },
//                               onLongPress: () {
//                                 // clear all digits from dial pad
//                                 try {
//                                   cursorCurrentIndex = 0;
//                                   numberDigits.clear();
//                                   digitsController.clear();
//                                 } catch (e) {}
//                               },
//                             )
//                         )
//                       ]
//                   ),
//                   const Divider(
//                     color: Colors.grey,
//                     thickness: 0.2,
//                   ),
//
//                   //1 2 3
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//
//                         Flexible(
//                           flex: 1,
//                           fit: FlexFit.tight,
//                           child: GestureDetector(
//                             child: Container(
//                               padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
//                               decoration: const BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.all(Radius.circular(50)),
//                               ),
//                               child: Column(
//                                 children: const [
//                                   SizedBox(height: 10),
//                                   Text("1", style: TextStyle(
//                                       fontSize: 30, color: Colors.black),),
//                                   SizedBox(height: 10),
//                                 ],
//                               ),
//                             ),
//
//                             onTap: () {
//                               setState(() {
//                                 numberDigits.insert(cursorCurrentIndex, "1");
//                                 setDigitInList();
//                               });
//                             },
//                           ),
//                         ),
//
//                         const SizedBox(width: 5),
//                         Flexible(
//                           flex: 1,
//                           fit: FlexFit.tight,
//                           child: GestureDetector(
//                             child: Container(
//                               padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
//                               decoration: const BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.all(Radius.circular(50)),
//                               ),
//                               child: Column(
//                                 children: const [
//                                   SizedBox(height: 5),
//                                   Text("2", style: TextStyle(
//                                       fontSize: 30, color: Colors.black),),
//                                   Text("ABC", style: TextStyle(
//                                       fontSize: 10, color: Colors.grey),),
//                                   SizedBox(height: 5),
//                                 ],
//                               ),
//                             ),
//
//                             onTap: () {
//                               numberDigits.insert(cursorCurrentIndex, "2");
//                               setDigitInList();
//                             },
//                           ),
//
//                         ),
//                         const SizedBox(width: 5),
//
//                         Flexible(
//                           flex: 1,
//                           fit: FlexFit.tight,
//                           child: GestureDetector(
//                             child: Container(
//                               padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
//                               decoration: const BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.all(Radius.circular(50)),
//                               ),
//                               child: Column(
//                                 children: const [
//                                   SizedBox(height: 5),
//                                   Text("3", style: TextStyle(
//                                       fontSize: 30, color: Colors.black),),
//                                   Text("DEF", style: TextStyle(
//                                       fontSize: 10, color: Colors.grey),),
//                                   SizedBox(height: 5),
//                                 ],
//                               ),
//                             ),
//
//                             onTap: () {
//                               numberDigits.insert(cursorCurrentIndex, "3");
//                               setDigitInList();
//                             },
//                           ),
//
//                         ),
//                       ]
//                   ),
//
//                   const SizedBox(height: 5),
//                   //4 5 6
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//
//                         Flexible(
//                           flex: 1,
//                           fit: FlexFit.tight,
//                           child: GestureDetector(
//                             child: Container(
//                               padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
//                               decoration: const BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.all(Radius.circular(50)),
//                               ),
//                               child: Column(
//                                 children: const [
//                                   SizedBox(height: 5),
//                                   Text("4", style: TextStyle(
//                                       fontSize: 30, color: Colors.black),),
//                                   Text("GHI", style: TextStyle(
//                                       fontSize: 10, color: Colors.grey),),
//                                   SizedBox(height: 5),
//                                 ],
//                               ),
//                             ),
//
//                             onTap: () {
//                               numberDigits.insert(cursorCurrentIndex, "4");
//                               setDigitInList();
//                             },
//                           ),
//
//                         ),
//
//                         const SizedBox(width: 5),
//
//                         Flexible(
//                           flex: 1,
//                           fit: FlexFit.tight,
//                           child: GestureDetector(
//                             child: Container(
//                               padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
//                               decoration: const BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.all(Radius.circular(50)),
//                               ),
//                               child: Column(
//                                 children: const [
//                                   SizedBox(height: 5),
//                                   Text("5", style: TextStyle(
//                                       fontSize: 30, color: Colors.black),),
//                                   Text("JKL", style: TextStyle(
//                                       fontSize: 10, color: Colors.grey),),
//                                   SizedBox(height: 5),
//                                 ],
//                               ),
//                             ),
//
//                             onTap: () {
//                               numberDigits.insert(cursorCurrentIndex, "5");
//                               setDigitInList();
//                             },
//                           ),
//
//                         ),
//
//                         const SizedBox(width: 5),
//                         Flexible(
//                           flex: 1,
//                           fit: FlexFit.tight,
//                           child: GestureDetector(
//                             child: Container(
//                               padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
//                               decoration: const BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.all(Radius.circular(50)),
//                               ),
//                               child: Column(
//                                 children: const [
//                                   SizedBox(height: 5),
//                                   Text("6", style: TextStyle(
//                                       fontSize: 30, color: Colors.black),),
//                                   Text("MNO", style: TextStyle(
//                                       fontSize: 10, color: Colors.grey),),
//                                   SizedBox(height: 5),
//                                 ],
//                               ),
//                             ),
//
//                             onTap: () {
//                               numberDigits.insert(cursorCurrentIndex, "6");
//                               setDigitInList();
//                             },
//                           ),
//
//                         ),
//                       ]
//                   ),
//
//                   const SizedBox(height: 5),
//
//                   //7 8 9
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//
//                         Flexible(
//                           flex: 1,
//                           fit: FlexFit.tight,
//                           child: GestureDetector(
//                             child: Container(
//                               padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
//                               decoration: const BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.all(Radius.circular(50)),
//                               ),
//                               child: Column(
//                                 children: const [
//                                   SizedBox(height: 5),
//                                   Text("7", style: TextStyle(
//                                       fontSize: 30, color: Colors.black),),
//                                   Text("PQRS", style: TextStyle(
//                                       fontSize: 10, color: Colors.grey),),
//                                   SizedBox(height: 5),
//                                 ],
//                               ),
//                             ),
//
//                             onTap: () {
//                               numberDigits.insert(cursorCurrentIndex, "7");
//                               setDigitInList();
//                             },
//                           ),
//
//                         ),
//
//                         const SizedBox(width: 5),
//                         Flexible(
//                           flex: 1,
//                           fit: FlexFit.tight,
//                           child: GestureDetector(
//                             child: Container(
//                               padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
//                               decoration: const BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.all(Radius.circular(50)),
//                               ),
//                               child: Column(
//                                 children: const [
//                                   SizedBox(height: 5),
//                                   Text("8", style: TextStyle(
//                                       fontSize: 30, color: Colors.black),),
//                                   Text("TUV", style: TextStyle(
//                                       fontSize: 10, color: Colors.grey),),
//                                   SizedBox(height: 5),
//                                 ],
//                               ),
//                             ),
//
//                             onTap: () {
//                               numberDigits.insert(cursorCurrentIndex, "8");
//                               setDigitInList();
//                             },
//                           ),
//
//                         ),
//                         const SizedBox(width: 5),
//                         Flexible(
//                           flex: 1,
//                           fit: FlexFit.tight,
//                           child: GestureDetector(
//                             child: Container(
//                               padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
//                               decoration: const BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.all(Radius.circular(50)),
//                               ),
//                               child: Column(
//                                 children: const [
//                                   SizedBox(height: 5),
//                                   Text("9", style: TextStyle(
//                                       fontSize: 30, color: Colors.black),),
//                                   Text("WXYZ", style: TextStyle(
//                                       fontSize: 10, color: Colors.grey),),
//                                   SizedBox(height: 5),
//                                 ],
//                               ),
//                             ),
//
//                             onTap: () {
//                               numberDigits.insert(cursorCurrentIndex, "9");
//                               setDigitInList();
//                             },
//                           ),
//
//                         ),
//                       ]
//                   ),
//
//                   const SizedBox(height: 5),
//                   //* 0 #
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//
//                         Flexible(
//                           flex: 1,
//                           fit: FlexFit.tight,
//                           child: GestureDetector(
//                             child: Container(
//                               padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
//                               decoration: const BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.all(Radius.circular(50)),
//                               ),
//                               child: Column(
//                                 children: const [
//                                   SizedBox(height: 10),
//                                   Text("*", style: TextStyle(
//                                       fontSize: 30, color: Colors.black),),
//                                   SizedBox(height: 10),
//                                 ],
//                               ),
//                             ),
//
//                             onTap: () {
//                               numberDigits.insert(cursorCurrentIndex, "*");
//                               setDigitInList();
//                             },
//                           ),
//
//                         ),
//
//                         const SizedBox(width: 5),
//                         Flexible(
//                           flex: 1,
//                           fit: FlexFit.tight,
//                           child: GestureDetector(
//                             child: Container(
//                               padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
//                               decoration: const BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.all(Radius.circular(50)),
//                               ),
//                               child: Column(
//                                 children: const [
//                                   SizedBox(height: 5),
//                                   Text("0", style: TextStyle(
//                                       fontSize: 30, color: Colors.black),),
//                                   Text("+", style: TextStyle(
//                                       fontSize: 10, color: Colors.grey),),
//                                   SizedBox(height: 5),
//                                 ],
//                               ),
//                             ),
//
//                             onTap: () {
//                               numberDigits.insert(cursorCurrentIndex, "0");
//                               setDigitInList();
//                             },
//                             onLongPress: () {
//                               numberDigits.insert(cursorCurrentIndex, "+");
//                               setDigitInList();
//                             },
//                           ),
//
//                         ),
//                         const SizedBox(width: 5),
//
//                         Flexible(
//                           flex: 1,
//                           fit: FlexFit.tight,
//                           child: GestureDetector(
//                             child: Container(
//                               padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
//                               decoration: const BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.all(Radius.circular(50)),
//                               ),
//                               child: Column(
//                                 children: const [
//                                   SizedBox(height: 10),
//                                   Text("#", style: TextStyle(
//                                       fontSize: 30, color: Colors.black),),
//                                   SizedBox(height: 10),
//                                 ],
//                               ),
//                             ),
//
//                             onTap: () {
//                               numberDigits.insert(cursorCurrentIndex, "#");
//                               setDigitInList();
//                             },
//                           ),
//
//                         ),
//
//                       ]
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   //call button
//                   Center(
//                       child: CircleAvatar(
//                           backgroundColor: Colors.green,
//                           radius: 35,
//                           child: IconButton(
//                             icon: const Icon(Icons.call, size: 30,color: Colors.white,),
//                             onPressed: () {
//                               if (digitsController.text.toString().isNotEmpty && SipAccountStatus.sipAccountStatus) {
//                                 Navigator.pop(context);
//
//                                 String name =  callerName.toString().trim().isEmpty? "Unknown" : callerName.toString().trim();
//                                 Navigator.push(
//                                     context, MaterialPageRoute(builder: (context) =>
//                                     CallUI(
//                                       phoneNumber: digitsController.text
//                                           .toString().trim(), callerName: name,
//                                     )));
//                               }
//                             },
//                           )
//                       )
//                   )
//
//
//                   //SizedBox(height: 50)
//                 ]
//             ),
//           ),
//         );
//       }
//
//
//   void setDigitInList() {
//     cursorCurrentIndex++;
//     String number = "";
//     for (var element in numberDigits) {
//       number += element;
//     }
//
//     digitsController.text = number;
//     digitsController.selection =
//         TextSelection.fromPosition(TextPosition(offset: cursorCurrentIndex));
//   }
//
//   void removeDigitFromList() {
//     cursorCurrentIndex--;
//     String number = "";
//     for (var element in numberDigits) {
//       number += element;
//     }
//
//     digitsController.text = number;
//     digitsController.selection =
//         TextSelection.fromPosition(TextPosition(offset: cursorCurrentIndex));
//   }
//
//   //Search field
//   late String searchKey;
//
//   Widget searchContacts() {
//     return TextField(
//       // controller: searchController,
//         maxLines: 1,
//         decoration: const InputDecoration(
//             hintText: "Search contacts ...",
//             border: InputBorder.none,
//             prefixIcon: Icon(Icons.search_outlined)
//         ),
//
//         onChanged: (keyword) {
//           if (keyword.isNotEmpty) {
//             setState(() {
//               searchKey = keyword;
//               isSearch = true;
//             });
//           }
//           else {
//             setState(() {
//               isSearch = false;
//             });
//           }
//           searchContact(keyword);
//         }
//     );
//   }
//
//   Widget getCallLogs() {
//     return FutureBuilder(
//
//         future: isSearch
//             ? DBHandler.instance.getDialPadSearch(searchKey)
//             : DBHandler.instance.getCallLogs(),
//         builder: (context, AsyncSnapshot snapshot) {
//
//           if (snapshot.data == null) {
//             return const Center(
//               child: SizedBox(
//                   height: 50, child: CircularProgressIndicator()),
//             );
//           }
//
//           return ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (BuildContext context, int index) {
//
//                 CallLogsModel callLogsModel = CallLogsModel.fromMap(
//                     snapshot.data[index]);
//
//                 if (callLogsModel.date == null) {
//                   return null;
//                 }
//
//                 return TextButton(
//                   style: ButtonStyle(
//                     padding: MaterialStateProperty.all<EdgeInsets>(
//                         const EdgeInsets.all(0)),),
//
//                   onPressed: () {
//                     setState(() {
//                       isDialPadShowing = true;
//                     });
//
//                     //reset previous number
//                     numberDigits = [];
//
//                     //Get current caller name
//                     callerName = callLogsModel.name.toString();
//
//                     // //reset previous digitsController
//                     digitsController.clear();
//
//                     //set cursorCurrentIndex of number field to 0
//                     cursorCurrentIndex = 0;
//
//                     for (int i = 0; i < callLogsModel.phoneNumber
//                         .toString()
//                         .trim()
//                         .length; i++) {
//                       numberDigits.add(
//                           callLogsModel.phoneNumber.toString().trim()[i]);
//                       setDigitInList();
//                     }
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 5.0,left: 5.0),
//                     child: Card(
//                       elevation: 0.5,
//                       child: Container(
//                         padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                         //margin: const EdgeInsets.only(top: 5),
//
//                         child: Row(
//
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(callLogsModel.name.toString(),
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold),),
//
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//
//                                     if(callLogsModel.type.toString().contains(
//                                         "Missed"))
//                                       Icon(Icons.call_missed,
//                                           color: Colors.redAccent)
//
//                                     else
//                                       if(callLogsModel.type.toString().contains(
//                                           "Incoming"))
//                                         Icon(Icons.call_received,
//                                             color: Colors.grey,size: 10,)
//
//                                       else
//                                         Icon(Icons.call_made_outlined,
//                                             color: Colors
//                                                 .blue,size: 15,),
//
//                                     Text(callLogsModel.phoneNumber.toString()),
//                                   ],
//                                 ),
//
//                                 Text(callLogsModel.date.toString().substring(0,
//                                     callLogsModel.date.toString().indexOf(" ")),
//                                   style: TextStyle(fontSize: 11),)
//
//                               ],
//                             ),
//
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//
//                                 Text(callLogsModel.time.toString()),
//                                 const SizedBox(width: 6),
//
//                                 //call history button
//                                 IconButton(icon: Icon(Icons.info_outline,color: Colors.blue[200],),
//                                     onPressed: () {
//                                       Navigator.push(context,
//                                           MaterialPageRoute(builder: (context) =>
//                                               CallLogDetails(
//                                                   contactName: callLogsModel.name
//                                                       .toString(),
//                                                   contactNumber: callLogsModel
//                                                       .phoneNumber.toString())));
//                                     }
//                                 )
//
//                               ],
//
//                             )
//
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }
//           );
//         }
//     );
//   }
//
//
//   Widget getContactsTabView() {
//     return FutureBuilder(
//         future: isSearch ? getSearchPhoneContacts() : getPhoneContacts(),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.data == null) {
//             return const Center(
//               child: SizedBox(
//                   height: 50, child: CircularProgressIndicator()),
//             );
//           }
//
//           return ListView.builder(
//               semanticChildCount: snapshot.data.length,
//               itemCount: snapshot.data.length,
//               itemBuilder: (context, int index) {
//                 if (snapshot.data[index].phones.isEmpty) {
//                   return const Text("");
//                 }
//
//                 // var phones = snapshot.data[index].phones.first.normalizedNumber;
//                 var phones = snapshot.data[index].phones.first.number;
//                 var photo = snapshot.data[index].photo;
//                 var name = snapshot.data[index].displayName;
//
//                 return ListTile(
//                   title: Text(name),
//                   subtitle: Text(phones.toString()),
//                   leading: photo != null ? CircleAvatar(
//                       radius: 45, child: Image.memory(photo)) : CircleAvatar(
//                       radius: 45,
//                       child: Text(name[0],
//                         style: const TextStyle(
//                             fontSize: 30, fontWeight: FontWeight.bold),)
//                   ),
//
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(
//                         builder: (context) =>
//                             ContactsDetails(
//                                 clientName: snapshot.data[index].displayName,
//                                 companyName: "Phone Contact",
//                                 phoneNumber: phones.toString())));
//                   },
//                 );
//               }
//
//           );
//         }
//     );
//   }
//
//
//   //Return all phone contacts
//   List<Contact> tempContactList = [];
//
//   Future<List<Contact>> getPhoneContacts() async {
//     var temp = await FlutterContacts.getContacts(
//         withProperties: true, withThumbnail: true, withPhoto: true);
//     tempContactList = temp;
//     return temp;
//   }
//
//   //Provide searched contacts list
//   Future<List<Contact>> getSearchPhoneContacts() async {
//     return searchContactList;
//   }
//
//
//   // Search a contact from contacts list by keyword
//   List<Contact> searchContactList = [];
//
//   void searchContact(String keyword) {
//     setState(() {
//       isSearch = true;
//       searchContactList = [];
//     });
//
//     if (keyword.isEmpty) {
//       searchContactList = tempContactList;
//       setState(() {
//         isSearch = false;
//       });
//     }
//     else {
//       setState(() {
//         if (RegExp(r'^[0-9]+$').hasMatch(keyword)) {
//           searchContactList = tempContactList.where((contact) =>
//               contact.phones.toString().toLowerCase().contains(
//                   keyword.toLowerCase())).toList();
//         } else {
//           searchContactList = tempContactList.where((contact) =>
//               contact.displayName.toLowerCase().contains(keyword.toLowerCase()))
//               .toList();
//         }
//         isSearch = true;
//       });
//     }
//   }
//
//
// }
//
//

/// new dailpad design chatgpt
//
// import 'package:flutter/material.dart';
//
// class SipDialPad extends StatefulWidget {
//   const SipDialPad({Key? key, required this.phoneNumber, required this.callerName}) : super(key: key);
//
//   final String phoneNumber;
//   final String callerName;
//
//   @override
//   State<SipDialPad> createState() => _SipDialPadState();
// }
//
// class _SipDialPadState extends State<SipDialPad> {
//
//
//   TextEditingController digitsController = TextEditingController();
//   List<String> numberDigits = [];
//   int cursorCurrentIndex = 0;
//   bool isDialPadShowing = false;
//   String? callerName;
//
//   @override
//   void initState() {
//     super.initState();
//     callerName = widget.callerName;
//   }
//
//   @override
//   void dispose() {
//     digitsController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.phoneNumber.isNotEmpty) {
//       for (int i = 0; i < widget.phoneNumber.length; i++) {
//         numberDigits.add(widget.phoneNumber[i]);
//         setDigitInList();
//       }
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dial Pad'),
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.centerLeft,
//               end: Alignment.centerRight,
//               colors: [Colors.blueAccent, Colors.redAccent],
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(child: Container()), // Spacer
//           getDialPad(),
//         ],
//       ),
//     );
//   }
//
//   Widget getDialPad() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: Column(
//         children: [
//           TextField(
//             controller: digitsController,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 24),
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               filled: true,
//               fillColor: Colors.white,
//             ),
//             readOnly: true,
//           ),
//           SizedBox(height: 20),
//           GridView.count(
//             crossAxisCount: 3,
//             shrinkWrap: true,
//             childAspectRatio: 1.5,
//             mainAxisSpacing: 10,
//             crossAxisSpacing: 10,
//             children: [
//               for (var i = 1; i <= 9; i++) _buildDialButton(i.toString()),
//               _buildDialButton('*'),
//               _buildDialButton('0'),
//               _buildDialButton('#'),
//             ],
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildActionButton(Icons.backspace, Colors.red, () {
//                 if (digitsController.text.isNotEmpty) {
//                   setState(() {
//                     numberDigits.removeLast();
//                     setDigitInList();
//                   });
//                 }
//               }),
//               _buildActionButton(Icons.call, Colors.green, () {
//                 // Implement call functionality
//               }),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDialButton(String digit) {
//     return Material(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(15),
//       child: InkWell(
//         onTap: () => _onDigitPressed(digit),
//         borderRadius: BorderRadius.circular(15),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.3),
//                 spreadRadius: 1,
//                 blurRadius: 5,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Center(
//             child: Text(
//               digit,
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildActionButton(IconData icon, Color color, VoidCallback onPressed) {
//     return Material(
//       color: color,
//       borderRadius: BorderRadius.circular(30),
//       child: InkWell(
//         onTap: onPressed,
//         borderRadius: BorderRadius.circular(30),
//         child: Container(
//           width: 60,
//           height: 60,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             boxShadow: [
//               BoxShadow(
//                 color: color.withOpacity(0.5),
//                 spreadRadius: 2,
//                 blurRadius: 8,
//                 offset: Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Icon(icon, color: Colors.white, size: 30),
//         ),
//       ),
//     );
//   }
//
//   void _onDigitPressed(String digit) {
//     setState(() {
//       numberDigits.add(digit);
//       setDigitInList();
//     });
//   }
//
//   void setDigitInList() {
//     String number = numberDigits.join();
//     digitsController.text = number;
//     cursorCurrentIndex = number.length;
//     digitsController.selection = TextSelection.fromPosition(TextPosition(offset: cursorCurrentIndex));
//   }
// }

///

/// New design dailpad beautiful design and very good working
///
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import 'package:marquee/marquee.dart';

import '../constants/Constants.dart';
import '../contacts/ContactsDetails.dart';
import 'CallUI.dart';
import 'SipAccountStatus.dart';
import 'call_logs/CallLogDetails.dart';
import '../database/DBHandler.dart';
import 'call_logs/CallLogsModel.dart';

class SipDialPad extends StatefulWidget {
  const SipDialPad(
      {Key? key, required this.phoneNumber, required this.callerName})
      : super(key: key);

  final String phoneNumber;
  final String callerName;

  @override
  State<SipDialPad> createState() => _SipDialPadState();
}

class _SipDialPadState extends State<SipDialPad> {
  TextEditingController digitsController = TextEditingController();
  List<String> numberDigits = [];
  int cursorCurrentIndex = 0;

  bool isDialPadShowing = false;
  String? callerName;

  /*
      false = history search
      true = contacts search
       */
  bool isSearch = false;

  @override
  void initState() {
    // TODO: implement initState
    callerName = widget.callerName;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    digitsController.clear();
    numberDigits.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.phoneNumber.isNotEmpty) {
      for (int i = 0; i < widget.phoneNumber.length; i++) {
        numberDigits.add(widget.phoneNumber[i]);
        setDigitInList();
      }
    }

    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: onBackPressed,
        child: Scaffold(
            appBar: AppBar(
              // New Changed

              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.blueAccent,
                        Colors.blueAccent,
                        Colors.redAccent,
                      ]),
                ),
              ),

              // backgroundColor: Color.fromRGBO(225, 217, 221, 1.0),
              // systemOverlayStyle: const SystemUiOverlayStyle(
              //     statusBarColor:Color.fromRGBO(225, 217, 221, 1.0), ),
              centerTitle: true,
              //Search text field
              title: Container(
                  height: 35,
                  padding: const EdgeInsets.only(left: 0, right: 2),
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(5)),
                  child: searchContacts()),

              actions: [
                // Searching button

                //SIP Account active indicator
                SipAccountStatus.sipAccountStatus
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromRGBO(0, 255, 0, 1),
                            ),
                          ),
                          SizedBox(
                              width: 40,
                              height: 15,
                              child: Marquee(
                                text: SipAccountStatus.extension,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                scrollAxis: Axis.horizontal,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                blankSpace: 10.0,
                                velocity: 50.0,
                                textDirection: TextDirection.ltr,
                                pauseAfterRound: const Duration(seconds: 1),
                                accelerationDuration:
                                    const Duration(seconds: 0),
                                accelerationCurve: Curves.easeInCirc,
                                decelerationDuration:
                                    const Duration(milliseconds: 500),
                                decelerationCurve: Curves.easeInCirc,
                              )),
                        ],
                      )
                    : Center(
                        child: Container(
                          width: 20,
                          height: 20,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromRGBO(100, 100, 100, 01),
                          ),
                        ),
                      ),

                const SizedBox(width: 10)
              ],
            ),
            floatingActionButton: Visibility(
              visible: !isDialPadShowing,
              child: FloatingActionButton(
                child: Container(
                  width: 60,
                  height: 60,
                  child: const Icon(Icons.dialpad, size: 30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      colors: [
                        Colors.blueAccent,
                        Colors.blueAccent,
                        Colors.redAccent,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    //set
                    if (isDialPadShowing) {
                      isDialPadShowing = false;
                    } else if (!isDialPadShowing) {
                      isDialPadShowing = true;
                    }
                  });
                },
              ),
            ),
            body: Column(
              children: [
                //Call logs and Contacts tap
                const TabBar(
                    labelColor: primaryColor,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.history),
                        text: "History",
                      ),
                      Tab(
                        icon: Icon(Icons.people_alt_outlined),
                        text: "Contacts",
                      ),
                    ]),

                const SizedBox(height: 5),

                //Tab pages
                Expanded(
                  child: TabBarView(children: [
                    //Display call logs
                    getCallLogs(),
                    //Display Phone contacts
                    getContactsTabView(),
                  ]),
                ),

                //DialPad
                getDialPad()
              ],
            )),
      ),
    );
  }

  // Back button alert
  Future<bool> onBackPressed() async {
    if (isDialPadShowing) {
      setState(() {
        isDialPadShowing = false;
      });
      return false;
    }
    return true;
  }

  Widget getDialPad() {
    return Visibility(
      visible: isDialPadShowing,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            TextField(
              controller: digitsController,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              readOnly: true,
            ),
            SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              childAspectRatio: 1.5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                for (var i = 1; i <= 9; i++) _buildDialButton(i.toString()),
                _buildDialButton('*'),
                _buildDialButton('0'),
                _buildDialButton('#'),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(Icons.backspace, Colors.red, () {
                  if (digitsController.text.isNotEmpty) {
                    setState(() {
                      numberDigits.removeLast();
                      setDigitInList();
                    });
                  }
                }),
                _buildActionButton(Icons.call, Colors.green, () {
                  // Implement call functionality

                  if (digitsController.text.toString().isNotEmpty &&
                      SipAccountStatus.sipAccountStatus) {
                    Navigator.pop(context);

                    String name = callerName.toString().trim().isEmpty
                        ? "Unknown"
                        : callerName.toString().trim();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CallUI(
                                  phoneNumber:
                                      digitsController.text.toString().trim(),
                                  callerName: name,
                                )));
                  }
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialButton(String digit) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () => _onDigitPressed(digit),
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              digit,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon, Color color, VoidCallback onPressed) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
      ),
    );
  }

  void _onDigitPressed(String digit) {
    setState(() {
      numberDigits.add(digit);
      setDigitInList();
    });
  }

  void setDigitInList() {
    String number = numberDigits.join();
    digitsController.text = number;
    cursorCurrentIndex = number.length;
    digitsController.selection =
        TextSelection.fromPosition(TextPosition(offset: cursorCurrentIndex));
  }

  //Search field
  late String searchKey;

  Widget searchContacts() {
    return TextField(
        // controller: searchController,
        maxLines: 1,
        decoration: const InputDecoration(
            hintText: "Search contacts ...",
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search_outlined)),
        onChanged: (keyword) {
          if (keyword.isNotEmpty) {
            setState(() {
              searchKey = keyword;
              isSearch = true;
            });
          } else {
            setState(() {
              isSearch = false;
            });
          }
          searchContact(keyword);
        });
  }

  Widget getCallLogs() {
    return FutureBuilder(
        future: isSearch
            ? DBHandler.instance.getDialPadSearch(searchKey)
            : DBHandler.instance.getCallLogs(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: SizedBox(height: 50, child: CircularProgressIndicator()),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                CallLogsModel callLogsModel =
                    CallLogsModel.fromMap(snapshot.data[index]);

                if (callLogsModel.date == null) {
                  return null;
                }

                return TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(0)),
                  ),
                  onPressed: () {
                    setState(() {
                      isDialPadShowing = true;
                    });

                    //reset previous number
                    numberDigits = [];

                    //Get current caller name
                    callerName = callLogsModel.name.toString();

                    // //reset previous digitsController
                    digitsController.clear();

                    //set cursorCurrentIndex of number field to 0
                    cursorCurrentIndex = 0;

                    for (int i = 0;
                        i < callLogsModel.phoneNumber.toString().trim().length;
                        i++) {
                      numberDigits
                          .add(callLogsModel.phoneNumber.toString().trim()[i]);
                      setDigitInList();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                    child: Card(
                      elevation: 0.5,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        //margin: const EdgeInsets.only(top: 5),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  callLogsModel.name.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (callLogsModel.type
                                        .toString()
                                        .contains("Missed"))
                                      Icon(Icons.call_missed,
                                          color: Colors.redAccent)
                                    else if (callLogsModel.type
                                        .toString()
                                        .contains("Incoming"))
                                      Icon(
                                        Icons.call_received,
                                        color: Colors.grey,
                                        size: 10,
                                      )
                                    else
                                      Icon(
                                        Icons.call_made_outlined,
                                        color: Colors.blue,
                                        size: 15,
                                      ),
                                    Text(callLogsModel.phoneNumber.toString()),
                                  ],
                                ),
                                Text(
                                  callLogsModel.date.toString().substring(
                                      0,
                                      callLogsModel.date
                                          .toString()
                                          .indexOf(" ")),
                                  style: TextStyle(fontSize: 11),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(callLogsModel.time.toString()),
                                const SizedBox(width: 6),

                                //call history button
                                IconButton(
                                    icon: Icon(
                                      Icons.info_outline,
                                      color: Colors.blue[200],
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CallLogDetails(
                                                      contactName: callLogsModel
                                                          .name
                                                          .toString(),
                                                      contactNumber:
                                                          callLogsModel
                                                              .phoneNumber
                                                              .toString())));
                                    })
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }

  Widget getContactsTabView() {
    return FutureBuilder(
        future: isSearch ? getSearchPhoneContacts() : getPhoneContacts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: SizedBox(height: 50, child: CircularProgressIndicator()),
            );
          }

          return ListView.builder(
              semanticChildCount: snapshot.data.length,
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index) {
                if (snapshot.data[index].phones.isEmpty) {
                  return const Text("");
                }

                // var phones = snapshot.data[index].phones.first.normalizedNumber;
                var phones = snapshot.data[index].phones.first.number;
                var photo = snapshot.data[index].photo;
                var name = snapshot.data[index].displayName;

                return ListTile(
                  title: Text(name),
                  subtitle: Text(phones.toString()),
                  leading: photo != null
                      ? CircleAvatar(radius: 45, child: Image.memory(photo))
                      : CircleAvatar(
                          radius: 45,
                          child: Text(
                            name[0],
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactsDetails(
                                clientName: snapshot.data[index].displayName,
                                companyName: "Phone Contact",
                                phoneNumber: phones.toString())));
                  },
                );
              });
        });
  }

  //Return all phone contacts
  List<Contact> tempContactList = [];

  Future<List<Contact>> getPhoneContacts() async {
    var temp = await FlutterContacts.getContacts(
        withProperties: true, withThumbnail: true, withPhoto: true);
    tempContactList = temp;
    return temp;
  }

  //Provide searched contacts list
  Future<List<Contact>> getSearchPhoneContacts() async {
    return searchContactList;
  }

  // Search a contact from contacts list by keyword
  List<Contact> searchContactList = [];

  void searchContact(String keyword) {
    setState(() {
      isSearch = true;
      searchContactList = [];
    });

    if (keyword.isEmpty) {
      searchContactList = tempContactList;
      setState(() {
        isSearch = false;
      });
    } else {
      setState(() {
        if (RegExp(r'^[0-9]+$').hasMatch(keyword)) {
          searchContactList = tempContactList
              .where((contact) => contact.phones
                  .toString()
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
              .toList();
        } else {
          searchContactList = tempContactList
              .where((contact) => contact.displayName
                  .toLowerCase()
                  .contains(keyword.toLowerCase()))
              .toList();
        }
        isSearch = true;
      });
    }
  }
}
