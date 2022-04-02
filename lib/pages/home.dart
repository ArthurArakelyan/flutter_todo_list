import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';

// Widgets
import 'package:todo_list/widgets/TodoWidget/TodoWidget.dart';

// Utils
import 'package:todo_list/utils/todo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LocalStorage storage = LocalStorage('todo_app');

  List<Todo> todos = <Todo>[];
  String todoName = '';
  bool initialized = false;

  getTodos() {
    return storage.getItem('todos');
  }

  void save() {
    storage.setItem('todos', todoListToJson(todos));
  }

  void addTodo(String name) {
    setState(() {
      todos.add(Todo(name));
      save();
    });
  }

  void editTodo(Todo todo, String name) {
    setState(() {
      todo.name = name;
      save();
    });
  }

  void deleteTodo(Todo todo) {
    setState(() {
      todos.remove(todo);
      save();
    });
  }

  void toggleTodoDone(Todo todo) {
    setState(() {
      todo.done = !todo.done;
      save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: storage.ready,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!initialized) {
            var items = getTodos();

            if (items != null) {
              List<dynamic> decodedTodos = jsonDecode(items);
              List<Todo> newTodos = [];

              for (var todo in decodedTodos) {
                newTodos.add(Todo.fromJson(todo));
              }

              todos = newTodos;
            }

            initialized = true;
          }

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              Todo todo = todos[index];
              return TodoWidget(todo: todo, deleteTodo: deleteTodo, toggleTodoDone: toggleTodoDone, editTodo: editTodo);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (BuildContext build) {
            return AlertDialog(
              title: const Text('Add Todo'),
              content: TextField(
                onChanged: (String value) {
                  todoName = value;
                },
                autofocus: true,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(build);
                    todoName = '';
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (todoName.trim() == '') {
                      return;
                    }

                    addTodo(todoName);
                    Navigator.pop(build);
                    todoName = '';
                  },
                  child: const Text('Save'),
                )
              ],
            );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}