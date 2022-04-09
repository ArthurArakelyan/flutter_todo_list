import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Widgets
import 'package:todo_list/widgets/TodoWidget/todo_widget.dart';

// Store
import 'package:todo_list/redux/store.dart';
import 'package:todo_list/redux/actions.dart';
import 'package:todo_list/redux/dispatch.dart';

// Utils
import 'package:todo_list/utils/todo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String todoName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
      ),
      body: StoreConnector<AppState, AppState>(
        onInit: (store) {
          store.dispatch(fetchTodosAction());
        },
        converter: (store) => store.state,
        builder: (context, state) {
          if (state.todosLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.todosError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min, // centering widget
                children: [
                  const Text(
                    'Can\'t get your todos.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  const Text(
                    'Please Check your internet connection!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  TextButton(
                    child: const Text('Try again', style: TextStyle(fontSize: 18)),
                    onPressed: () {
                      dispatch(fetchTodosAction(), context);
                    },
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (context, index) {
              Todo todo = state.todos[index];
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

                    dispatch(AddTodo(Todo(todoName)), context);

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