import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

import '../alert_dialog/CustomAlertDialg.dart';
import '../api/TaskCreateAPI.dart';
import '../components/LeadAssignToDropDownComponent.dart';
import '../constants/Constants.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key, required this.isCallFromDashboard})
      : super(key: key);
  final bool isCallFromDashboard;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  //Field controller variable
  TextEditingController taskStartTimeController = TextEditingController();
  TextEditingController taskEndTimeController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  late String taskStartTimePicker;
  late String taskEndTimePicker;
  late String priority;
  late String taskOrEvent;
  late String leadID;

  @override
  void initState() {
    // TODO: implement initState

    getContactPerson();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const Text(
              "Task/Event Creation",
              style: TextStyle(fontSize: 17),
            ),

            const SizedBox(height: 15),

            //Contact Person(Company) dropdown
            Visibility(
                visible: widget.isCallFromDashboard,
                child: getContactPersonDropdown()),

            const SizedBox(height: 10),

            //Event/Task dropdown
            getTaskTypeDropdown(),

            const SizedBox(height: 10),

            //Start time
            Card(
              elevation: 2,
              child: TextFormField(
                controller: taskStartTimeController,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                maxLines: 1,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    border: const OutlineInputBorder(),
                    labelText: "Start Time*",
                    hintText: "dd/mm/yy HH:MM ",
                    suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_month_outlined),
                        onPressed: () {
                          pickDate("start_time");
                        })),
              ),
            ),

            const SizedBox(height: 10),

            //End time
            Card(
              elevation: 2,
              child: TextFormField(
                controller: taskEndTimeController,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                maxLines: 1,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    border: const OutlineInputBorder(),
                    labelText: "End Time*",
                    hintText: "dd/mm/yy HH:MM ",
                    suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_month_outlined),
                        onPressed: () {
                          pickDate("end_time");
                        })),
              ),
            ),

            const SizedBox(height: 10),

            getPriorityDropdown(),

            const SizedBox(height: 10),

            //Assign to
            const LeadAssignToDropDownComponent(),

            const SizedBox(height: 10),

            //Note
            Card(
              elevation: 2,
              child: TextField(
                controller: noteController,
                maxLines: 1,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    border: OutlineInputBorder(),
                    labelText: "Note",
                    hintText: "Write a note.."),
              ),
            ),

            const SizedBox(height: 30),

            // New Changed Animated Button  // Nayeem Developer 01733364274
            Center(
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.blue,
                child: AnimatedButton(
                  width: 200,
                  text: 'Save',
                  isReverse: true,
                  selectedTextColor: Colors.blue,
                  transitionType: TransitionType.LEFT_TO_RIGHT,
                  // textStyle: submitTextStyle,
                  // backgroundColor: Colors.green,
                  // backgroundColor: Color.fromRGBO(55, 155, 155, 1.0),

                  borderRadius: 15,
                  borderWidth: 2,

                  onPress: () {
                    try {
                      if (contactPerson.contains("Select contact person")) {
                        CustomAlertDialog.showAlert(
                            "Contact Person field is required!", context);
                        return;
                      }

                      if (taskType.contains("Select a type")) {
                        CustomAlertDialog.showAlert(
                            "Event/Task field is required!", context);
                        return;
                      }

                      if (taskStartTimeController.text.isEmpty) {
                        CustomAlertDialog.showAlert(
                            "Start Time field is required!", context);
                        return;
                      }

                      if (taskEndTimeController.text.isEmpty) {
                        CustomAlertDialog.showAlert(
                            "End Time field is required!", context);
                        return;
                      }

                      if (taskPriority.contains("Select Priority")) {
                        CustomAlertDialog.showAlert(
                            "Priority field is required!", context);
                        return;
                      }

                      // if (assignTo.isEmpty) {
                      //   CustomAlertDialog.showAlert("Assign to field is required!", context);
                      //   return;
                      // }

                      TaskCreateAPI taskCreateApi = TaskCreateAPI(context);
                      // taskCreateApi.sendDataToServer(
                      // //    widget.isCallFromDashboard ? leadID : StaticVariable.leadModel.id.toString(),
                      //     StaticVariable.callStatus,
                      //     taskStartTimeController.text,
                      //     taskEndTimeController.text,
                      //     StaticVariable.assignTo,
                      //     taskOrEvent,
                      //     noteController.text,
                      //     priority
                      //  );
                    } catch (e) {}
                  },
                ),
              ),
            ),

            // Mazed Vai...
            // TextButton(
            //   style: TextButton.styleFrom(
            //     backgroundColor: Colors.blue.shade900,
            //     foregroundColor: Colors.white,),
            //   child: const SizedBox(height: 35, child: Center(child: Text("Save", style: TextStyle(fontSize: 17),))),
            //   onPressed: () {
            //
            //     try {
            //       if (contactPerson.contains("Select contact person")) {
            //         CustomAlertDialog.showAlert("Contact Person field is required!", context);
            //         return;
            //       }
            //
            //       if (taskType.contains("Select a type")) {
            //         CustomAlertDialog.showAlert("Event/Task field is required!", context);
            //         return;
            //       }
            //
            //       if (taskStartTimeController.text.isEmpty) {
            //         CustomAlertDialog.showAlert("Start Time field is required!", context);
            //         return;
            //       }
            //
            //       if (taskEndTimeController.text.isEmpty) {
            //         CustomAlertDialog.showAlert("End Time field is required!", context);
            //         return;
            //       }
            //
            //
            //       if (taskPriority.contains("Select Priority")) {
            //         CustomAlertDialog.showAlert("Priority field is required!", context);
            //         return;
            //       }
            //
            //       if (StaticVariable.assignTo.isEmpty) {
            //         CustomAlertDialog.showAlert("Assign to field is required!", context);
            //         return;
            //       }
            //
            //       TaskCreateAPI taskCreateApi = TaskCreateAPI(context);
            //       taskCreateApi.sendDataToServer(
            //           widget.isCallFromDashboard ? leadID : StaticVariable.leadModel.id.toString(),
            //           StaticVariable.callStatus,
            //           taskStartTimeController.text,
            //           taskEndTimeController.text,
            //           StaticVariable.assignTo,
            //           taskOrEvent,
            //           noteController.text,
            //           priority
            //       );
            //
            //     } catch (e) {}
            //   },
            // ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> pickDate(String mode) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2023, 3),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      if (mode.contains("start_time")) {
        taskStartTimePicker =
            "${numberFormat(pickedDate.year)}-${numberFormat(pickedDate.month)}-${pickedDate.day} ";
      } else {
        taskEndTimePicker =
            "${numberFormat(pickedDate.year)}-${numberFormat(pickedDate.month)}-${pickedDate.day} ";
      }
      _selectTime(mode);
    }
  }

  String numberFormat(int num) {
    if (num <= 9) {
      return "0$num";
    } else {
      return "$num";
    }
  }

  Future<void> _selectTime(String mode) async {
    TimeOfDay selectedDate = TimeOfDay.now();
    final TimeOfDay? timePicker = await showTimePicker(
      context: context,
      initialTime: selectedDate,
    );

    if (timePicker != null) {
      if (mode.contains("start_time")) {
        taskStartTimePicker += timePicker.format(context);
        taskStartTimeController.text = taskStartTimePicker;
      } else {
        taskEndTimePicker += timePicker.format(context);
        taskEndTimeController.text = taskEndTimePicker;
      }
    }
  }

  List<String> companyName = [];
  List<String> companyId = [];

  void getContactPerson() async {
    //  Map<String,List<String>> data = await CompanyNameAPI().fetch();

    // setState((){
    //   companyName = data.values.first;
    //   companyId = data.values.last;
    // });
  }

  String contactPerson = "Select contact person";
  Widget getContactPersonDropdown() {
    if (companyName.contains(null)) {
      return const Text("Contact person not found");
    }

    return Card(
      elevation: 2,
      child: DropdownSearch<String>(
        popupProps: const PopupProps.menu(
            showSearchBox: true,
            showSelectedItems: true,
            searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
              hintText: "Search by company/person name",
            ))),
        items: companyName,
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "Contact Person (Company)*",
            border: OutlineInputBorder(),
          ),
        ),
        onChanged: (value) {
          contactPerson = value!;
          leadID = companyId[companyName.indexOf(contactPerson)];
          print("lead ID $leadID");
        },
        selectedItem: contactPerson,
      ),
    );
  }

  String taskType = "Select a type";

  Widget getTaskTypeDropdown() {
    List dropdownList = ["Select a type", "Event", "Task"];

    return Card(
      elevation: 2,
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          border: OutlineInputBorder(),
          labelText: "Event/Task",
        ),
        isExpanded: false,
        value: taskType,
        onChanged: (value) {
          setState(() {
            taskType = value.toString();

            taskOrEvent = taskType;
            print(taskOrEvent);
          });
        },
        items: dropdownList.map((value) {
          return DropdownMenuItem(
              value: value,
              child: Text(value,
                  style: TextStyle(
                      color: taskType.contains(value.toString())
                          ? primaryColor
                          : Colors.black)));
        }).toList(),
        selectedItemBuilder: (BuildContext context) {
          return dropdownList.map((value) {
            return DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(color: Colors.black),
                ),
                value: value);
          }).toList();
        },
      ),
    );
  }

  String taskPriority = "Select Priority";
  Widget getPriorityDropdown() {
    List dropdownList = ["Select Priority", "Low", "Normal", "High"];

    return Card(
      // New Changed

      elevation: 2,
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          border: OutlineInputBorder(),
          labelText: "Priority*",
        ),
        isExpanded: false,
        value: taskPriority,
        onChanged: (value) {
          setState(() {
            taskPriority = value.toString();
            priority = dropdownList.indexOf(taskPriority).toString();
          });
        },
        items: dropdownList.map((value) {
          return DropdownMenuItem(
              value: value,
              child: Text(value,
                  style: TextStyle(
                      color: taskPriority.contains(value.toString())
                          ? primaryColor
                          : Colors.black)));
        }).toList(),
        selectedItemBuilder: (BuildContext context) {
          return dropdownList.map((value) {
            return DropdownMenuItem(
                value: value,
                child:
                    Text(value, style: const TextStyle(color: Colors.black)));
          }).toList();
        },
      ),
    );
  }
}
