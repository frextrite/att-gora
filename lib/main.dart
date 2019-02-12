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

  @override
  void initState() {
    super.initState();
    focusNewTodo = FocusNode();
  }

  @override
  void dispose() {
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
        focusNode: focusNewTodo,
        decoration:
            InputDecoration(border: InputBorder.none, hintText: 'att gora'),
      ),
    );
  }
}
