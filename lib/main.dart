// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:note_keeper_app/screens/note_detail.dart';
import 'package:note_keeper_app/screens/note_list.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NoteKeeper",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: NoteDetail(),
    );
    throw UnimplementedError();
  }
}
