import 'package:flutter/material.dart';
import 'package:todo_app/bloc/todo_bloc.dart';

Widget ListItem(ToDoNote note, ToDoBloc toDoBloc){
  return Dismissible(
    direction: DismissDirection.endToStart,
    key: Key(note.title),
    background: Container(
      alignment: AlignmentDirectional.centerEnd,
      color: Colors.red,
      child: Icon(Icons.delete, color: Colors.white,),
    ),
    onDismissed: (direction){
      toDoBloc.removeFromList(note);
    },
    child: ListTile(
      title: Text(note.title),
      subtitle: Text(note.description),
    ),
  );
}