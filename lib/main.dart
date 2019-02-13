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
      itemCount: todosList.length,
      itemBuilder: (context, i) {
        return Dismissible(
            key: Key(todosList[i] + i.toString()),
            onDismissed: (direction) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(todosList[i]),
              ));
              setState(() {
                todosList.removeAt(i);
              });
            },
            child: ListTile(
              title: Text(todosList[i]),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo'),
          backgroundColor: Color(0xFF727372),
        ),
        body: Container(
            decoration: BoxDecoration(
              color: Color(0xFFEAEBE9),
            ),
            child: Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFD3D4D2),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black54,
                        ),
                        controller: controllerTodo,
                        focusNode: focusNewTodo,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'att gora',
                            hintStyle: TextStyle(
                              color: Colors.black26,
                            )),
                        onSubmitted: (text) {
                          setState(() {
                            todosList.add(text);
                          });
                          controllerTodo.clear();
                          print('$todosList');
                        },
                      ))),
              Expanded(child: _buildTodoList())
            ])));
  }
}
