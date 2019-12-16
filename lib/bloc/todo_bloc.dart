import 'dart:async';

import 'package:todo_app/services/storage.dart';

class ToDoNote {
  String title;
  String description;
  
  ToDoNote(this.title, this.description);

  factory ToDoNote.fromJson(Map<String, dynamic> json) {
    return ToDoNote(json['title'], json['description']);
  }

  Map<String, dynamic> toMap(){
    return { "title": this.title, "description": this.description };
  }

}

class ToDoBloc {
  List<ToDoNote> toDoList = [];
  StreamController toDoStream = new StreamController<List<ToDoNote>>.broadcast();
  
  addToList(ToDoNote toDoNote) async {
    toDoList.add(toDoNote);
    toDoStream.sink.add(toDoList);
    await writeToDoList(toDoList);
  }

  removeFromList(ToDoNote toDoNote) async {
    toDoList.remove(toDoNote);
    toDoStream.sink.add(toDoList);
    await writeToDoList(toDoList);
  }

  initList() async {
    toDoList = await readToDoList();
    toDoStream.sink.add(toDoList);
  }

  dispose() async {
    await writeToDoList(toDoList);
    toDoStream.close();
  }

}