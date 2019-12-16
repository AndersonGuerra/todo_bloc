import 'package:flutter/material.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/widgets/list_item.dart';
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
          showDialog(context: context, builder: (context) => ToDoForm(toDoBloc));
        },
      ),
      body: FutureBuilder(
        future: toDoBloc.initList(),
        builder: (context, data){
          if (data==null) return Center(child: CircularProgressIndicator(),);
          return StreamBuilder<List<ToDoNote>>(
            stream: toDoBloc.toDoStream.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Center(child: Text("Sem tarefas"),);
              return Container(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(height: 0.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, index){
                    ToDoNote note = snapshot.data[index];
                    return ListItem(note, toDoBloc);
                  }
                ),
              );
            }
          );
        },
      ),
    );
  }
}