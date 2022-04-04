import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Widgets
import 'package:todo_list/widgets/TodoWidget/todo_widget.dart';

// Store
import 'package:todo_list/redux/store.dart';
import 'package:todo_list/redux/actions.dart';

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
  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
      ),
      body: StoreConnector<AppState, List<Todo>>(
        converter: (store) => store.state.todos,
        builder: (context, List<Todo> otherTodos) {
          return ListView.builder(
            itemCount: otherTodos.length,
            itemBuilder: (context, index) {
              Todo todo = otherTodos[index];
              return TodoWidget(todo: todo, index: index);
            }
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
                    
                    StoreProvider.of<AppState>(context)
                      .dispatch(AddTodo(Todo(todoName)));

                    Navigator.pop(build);
                    todoName = '';
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}