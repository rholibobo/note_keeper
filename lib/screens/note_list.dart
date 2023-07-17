// ignore_for_file: no_logic_in_create_state, dead_code, prefer_const_constructors, unused_local_variable

import "package:flutter/material.dart";

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
    throw UnimplementedError();
  }
}

class NoteListState extends State<NoteList> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: getListView(),
    );
    throw UnimplementedError();
  }

  ListView getListView() {
    TextStyle? titleStyle = Theme.of(context).textTheme.titleMedium;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.keyboard_arrow_right),

            ),
            title: Text("Dummy Title", style: titleStyle,),
            subtitle: Text("Dummy Date"),
          ),
        );
      },
    );
  }
}
