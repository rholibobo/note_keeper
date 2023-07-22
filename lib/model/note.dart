// ignore_for_file: unused_field, unnecessary_this, prefer_collection_literals, unnecessary_null_comparison, body_might_complete_normally_nullable, unused_import, avoid_web_libraries_in_flutter

import 'dart:html';

class Note {
  int _id = 0;
  String _title = '';
  String? _description = '';
  String _date = '';
  int _priority = 0;

  Note(this._title, this._date, this._priority, this._id, [this._description]);

  Note.withId(this._id, this._title, this._date, this._priority,
      [this._description]);

  int get id => _id;
  String get title => _title;
  String get date => _date;
  int get priority => _priority;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set priority(int newPriority) {
    if (newPriority <= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  // Function to convert Note object to Map Object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = _id;
    }
    map["title"] = _title;
    map["description"] = _description;
    map["priority"] = _priority;
    map["date"] = _date;

    return map;
  }

  // Function to extract Note object from Map Object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map["id"];
    this._title = map["title"];
    this._description = map["description"];
    this._priority = map["priority"];
    this._date = map["date"];
  }
}
