import 'package:flutter/material.dart';
import 'package:todo_app/bloc/todo_bloc.dart';

class ToDoForm extends StatelessWidget {
  final _toDoBloc;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  ToDoForm(this._toDoBloc);

  validator(value){
    if (value.toString().isEmpty){
      return "Por favor insira algum texto";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
              title: Text("Nova tarefa"),
              content: Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Insira o título da tarefa."
                ),
                controller: _titleController,
                validator: (value) => validator(value),
              ),
              TextFormField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Insira uma descrição."
                ),
                controller: _descriptionController,
                validator: (value) => validator(value),
              ),
              Row(
                children: <Widget>[
                  MaterialButton(
                  child: Text("Cancelar"),
                  onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    child: Text("Inserir"),
                    onPressed: (){
                      if (_formKey.currentState.validate()){
                        ToDoNote _newNote = ToDoNote(_titleController.text, _descriptionController.text);
                        _toDoBloc.addToList(_newNote);
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ],
      ),
    ),
            );
    
    
  }
}