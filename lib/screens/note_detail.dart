// ignore_for_file: no_logic_in_create_state, prefer_final_fields, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";

class NoteDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteDetailState();
    throw UnimplementedError();
  }
}

class NoteDetailState extends State<NoteDetail> {
  // ignore: unused_field
  var _priority = ["High", "Low"];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Notes"),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // first element
              ListTile(
                title: DropdownButton<String>(
                    items: _priority.map((String dropdownValue) {
                      return DropdownMenuItem(
                          value: dropdownValue, child: Text(dropdownValue));
                    }).toList(),
                    style: textStyle,
                    value: "Low",
                    onChanged: (valueSelectedByUser) {
                      setState(() {
                        debugPrint("User selected $valueSelectedByUser");
                      });
                    }),
              ),
              // second Element
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: titleController,
                  style: textStyle,
                  onChanged: (value) {
                    debugPrint("Something changed in Title Text Field");
                  },
                  decoration: InputDecoration(
                      labelText: "Tilte",
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),

              // third element
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: descriptionController,
                  style: textStyle,
                  onChanged: (value) {
                    debugPrint("Something changed in Description Text Field");
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
                            foregroundColor:
                                Colors.white),
                        child: Text(
                          "Save",
                          textScaleFactor: 1.2,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Save button was clicked");
                          });
                        },
                      ),
                    ),
                    Container(width: 5.0,),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor:
                                Colors.white),
                        child: Text(
                          "Delete",
                          textScaleFactor: 1.2,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Delete button was clicked");
                          });
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));

    throw UnimplementedError();
  }
}
