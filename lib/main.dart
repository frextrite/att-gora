import 'package:flutter/material.dart';

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
  FocusNode focusNewTodo;
  TextEditingController controllerTodo;

  @override
  void initState() {
    super.initState();
    focusNewTodo = FocusNode();
    controllerTodo = TextEditingController();
  }

  @override
  void dispose() {
    controllerTodo.dispose();
    focusNewTodo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: TextField(
        controller: controllerTodo,
        focusNode: focusNewTodo,
        decoration:
            InputDecoration(border: InputBorder.none, hintText: 'att gora'),
      ),
    );
  }
}
