import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String _lastDeleted;
  List<String> todosList;
  Map<String, bool> isDone;
  FocusNode focusNewTodo;
  TextEditingController controllerTodo;

  @override
  void initState() {
    super.initState();
    isDone = {};
    _lastDeleted = '';
    todosList = [];
    focusNewTodo = FocusNode();
    controllerTodo = TextEditingController();
    _loadPersistent();
  }

  @override
  void dispose() {
    controllerTodo.dispose();
    focusNewTodo.dispose();
    super.dispose();
  }

  _loadPersistent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      todosList = preferences.getStringList('todosList') ?? [];
      for (String todo in todosList) {
        isDone[todo] = preferences.getBool(todo) ?? false;
      }
    });
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: todosList.length,
      itemBuilder: (context, i) {
        return Dismissible(
          key: Key(todosList[i] + i.toString()),
          onDismissed: (direction) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(todosList[i]),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    if (_lastDeleted != '') {
                      setState(() {
                        todosList.add(_lastDeleted);
                        _lastDeleted = '';
                      });
                    }
                  },
                ),
              ),
            );
            setState(() {
              _lastDeleted = todosList[i];
              todosList.removeAt(i);
            });
          },
          child: CheckboxListTile(
            activeColor: Colors.black,
            title: Text(
              todosList[i],
              style: TextStyle(
                fontSize: 18.0,
                decoration: isDone[todosList[i]]
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            value: isDone[todosList[i]],
            onChanged: (value) async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setBool(todosList[i], value);
              setState(() {
                isDone[todosList[i]] = value;
              });
            },
          ),
        );
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
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFD3D4D2),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextField(
                  cursorColor: Colors.black38,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black54,
                  ),
                  controller: controllerTodo,
                  focusNode: focusNewTodo,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: InputBorder.none,
                    hintText: 'What do you wish to do?',
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    ),
                  ),
                  onSubmitted: (text) async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    setState(() {
                      todosList = preferences.getStringList('todosList') ?? [];
                      for (String todo in todosList) {
                        isDone[todo] = preferences.getBool(todo) ?? false;
                      }
                      todosList.add(text);
                      isDone[text] = false;
                      preferences.setStringList('todosList', todosList);
                      preferences.setBool(text, isDone[text]);
                    });
                    controllerTodo.clear();
                    print('$todosList');
                  },
                ),
              ),
            ),
            Expanded(child: _buildTodoList())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FocusScope.of(context).requestFocus(focusNewTodo);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }
}
