// ignore_for_file: no_logic_in_create_state, prefer_final_fields, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, dead_code, use_key_in_widget_constructors, must_be_immutable, unnecessary_this, prefer_const_constructors_in_immutables, unused_import, unnecessary_null_comparison, body_might_complete_normally_nullable, no_leading_underscores_for_local_identifiers

import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:note_keeper_app/model/note.dart";
import "package:note_keeper_app/utils/database_helper.dart";
import "package:note_keeper_app/screens/note_detail.dart";
import "package:sqflite/sqflite.dart";

class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final Note note;

  NoteDetail(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.note, this.appBarTitle);
    throw UnimplementedError();
  }
}

class NoteDetailState extends State<NoteDetail> {
  // ignore: unused_field
  var _priorities = ["High", "Low"];

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Note note;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  NoteDetailState(this.note, this.appBarTitle);

  // NoteDetailState(String appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;

    var _globalFormKey = GlobalKey<FormState>();
    titleController.text = note.title;
    descriptionController.text = note.description;

    return Scaffold(
        appBar: AppBar(
          title: Text(this.appBarTitle),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: Form(
            key: _globalFormKey,
            child: ListView(
              children: <Widget>[
                // first element
                ListTile(
                  title: DropdownButton<String>(
                      items: _priorities.map((String dropdownValue) {
                        return DropdownMenuItem(
                            value: dropdownValue, child: Text(dropdownValue));
                      }).toList(),
                      style: textStyle,
                      value: getPriorityAsString(note.priority),
                      onChanged: (valueSelectedByUser) {
                        setState(() {
                          debugPrint("User selected $valueSelectedByUser");
                          updatePriorityAsInt(valueSelectedByUser!);
                        });
                      }),
                ),
                // second Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Title";
                      }
                    },
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint("Something changed in Title Text Field");
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: "Title",
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.red,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),

                // third element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextFormField(
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint("Something changed in Description Text Field");
                      updateDescription();
                    },
                    decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),

                // fourth element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white),
                          child: Text(
                            "Save",
                            textScaleFactor: 1.2,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button was clicked");
                              if (_globalFormKey.currentState!.validate()) {
                                _save();
                              }
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white),
                          child: Text(
                            "Delete",
                            textScaleFactor: 1.2,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Delete button was clicked");
                              _delete();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));

    throw UnimplementedError();
  }

  // Convert the string priority in the form to integer before saving it to database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Convert int priority to String priority and displaay it to user in Dropdown
  String getPriorityAsString(int value) {
    String? priority;
    switch (value) {
      case 1:
        priority = _priorities[0]; //High
        break;
      case 2:
        priority = _priorities[1]; //Low
        break;
    }
    return priority!;
  }

  // Helper functions
  // Update the title of Note Object
  void updateTitle() {
    note.title = titleController.text;
  }

  // Update tehdescription of Note object
  void updateDescription() {
    note.description = descriptionController.text;
  }

  // Save data to database
  void _save() async {
    moveToLastScreen();

    note.date = DateFormat.yMMMd().format(DateTime.now());

    int result;
    if (note.id > 0) {
      //case 1: Update operation
      result = await helper.updateNote(note);
    } else {
      // case2: Insert operation
      result = await helper.insertNote(note);
    }

    if (result != 0) {
      //success
      _showAlertDialog("Status", "Note saved successfully");
    } else {
      //failure
      _showAlertDialog("Status", "Problem saving note");
    }
  }

  // display alert dialog
  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  // delete function

  void _delete() async {
    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW NOTE i.e he has come to the detail page by pressing the FAB of NoteList page
    if (note.id == null) {
      _showAlertDialog("Status", "No note was deleted");
      return;
    }

    //Case 2: User is trying to delete the old note that already has a valid ID
    int result = await helper.deleteNote(note.id);
    if (result > 0) {
      _showAlertDialog("Status", "Note deleted Successfully");
    } else {
      _showAlertDialog("Status", "Error Occured while deleting Note");
    }
  }
}
