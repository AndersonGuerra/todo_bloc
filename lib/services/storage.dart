import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/bloc/todo_bloc.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/todo');
}

Future<File> writeToDoList(List<ToDoNote> toDoList) async {
  final file = await _localFile;
  List<Map<String, dynamic>> toDoListMap = [];
  toDoList.forEach((toDo){
    toDoListMap.add(toDo.toMap());
  });
  // Write the file.
  return file.writeAsString(json.encode(toDoListMap));
}

Future<List<ToDoNote>> readToDoList() async {
  try {
    final file = await _localFile;

    // Read the file.
    String contents = await file.readAsString();
    var toDoJson = json.decode(contents);
    List<ToDoNote> toDoList = [];
    for (var todo in toDoJson) {
      ToDoNote note = ToDoNote.fromJson(todo);
      toDoList.add(note);
    }
    return toDoList;
  } catch (e) {
    // If encountering an error, return 0.
    return [];
  }
}
