import 'package:flutter/material.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/widgets/todo_form.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ToDoBloc toDoBloc = new ToDoBloc();

  @override
  void dispose() {
    toDoBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ToDo"),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: Text("Nova tarefa"),
              content: ToDoForm(toDoBloc),
            );
          });
        },
      ),
      body: StreamBuilder<List<ToDoNote>>(
        stream: toDoBloc.toDoStream.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return SizedBox();
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (ctx, index){
                  ToDoNote note = snapshot.data[index];
                  return ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.description),
                  );
                },
              ),
            ),
          );
        }
      ),
    );
  }
}