import 'package:flutter/material.dart';

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
  List<Todo> todos = <Todo>[];
  String todoName = '';

  @override
  void initState() {
    super.initState();

    todos.addAll([Todo('Buy milk'), Todo('Test')]);
  }

  void addTodo(String name) {
    setState(() {
      todos.add(Todo(name));
    });
  }

  void editTodo(Todo todo, String name) {
    setState(() {
      for (Todo element in todos) {
        if (element == todo) {
          element.name = name;
        }
      }
    });
  }

  void deleteTodo(Todo todo) {
    setState(() {
      todos.remove(todo);
    });
  }

  void toggleTodoDone(Todo todo) {
    setState(() {
      for (Todo element in todos) {
        if (element == todo) {
          element.done = !todo.done;
        }
      }
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
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          Todo todo = todos[index];
          return TodoWidget(todo: todo, deleteTodo: deleteTodo, toggleTodoDone: toggleTodoDone, editTodo: editTodo);
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