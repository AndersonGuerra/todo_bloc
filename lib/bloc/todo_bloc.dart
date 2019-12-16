import 'dart:async';

class ToDoNote {
  String title;
  String description;
  
  ToDoNote(this.title, this.description);
}

class ToDoBloc {
  List<ToDoNote> toDoList = [];
  StreamController toDoStream = new StreamController<List<ToDoNote>>.broadcast();
  
  addToList(ToDoNote toDoNote){
    toDoList.add(toDoNote);
    toDoStream.sink.add(toDoList);
  }

  removeFromList(ToDoNote toDoNote){
    toDoList.remove(toDoNote);
    toDoStream.sink.add(toDoList);
  }

  printList(){
    print(toDoList);
  }

  dispose(){
    toDoStream.close();
  }

}