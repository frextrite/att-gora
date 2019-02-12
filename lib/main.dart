import 'package:flutter/material.dart';
import 'dart:developer';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      home: Todo(),
    );
  }
}

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List<String> todosList;
  FocusNode focusNewTodo;
  TextEditingController controllerTodo;

  @override
  void initState() {
    super.initState();
    todosList = [];
    focusNewTodo = FocusNode();
    controllerTodo = TextEditingController();
  }

  @override
  void dispose() {
    controllerTodo.dispose();
    focusNewTodo.dispose();
    super.dispose();
  }

  Widget _buildTodoList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: todosList.length,
      itemBuilder: (context, i) {
        return Dismissible(
          key: Key(todosList[i]),
          onDismissed: (direction) {
            Scaffold
              .of(context)
              .showSnackBar(SnackBar(content: Text(todosList[i]),));
            setState(() {
              todosList.removeAt(i);
            });
          },
          child: ListTile(
            title: Text(todosList[i]),
          )
        );
      },
        
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo'),
        ),
        body: new Column(children: <Widget>[
          TextField(
            controller: controllerTodo,
            focusNode: focusNewTodo,
            decoration:
                InputDecoration(border: InputBorder.none, hintText: 'att gora'),
            onSubmitted: (text) {
              setState(() {
                todosList.add(text);
              });
              controllerTodo.clear();
              print('$todosList');
            },
          ),
          // _buildTodoList(),
          new Expanded(child: _buildTodoList())
        ]
      )
    );
  }
}
