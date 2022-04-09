import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Widgets
import 'package:todo_list/shared_widgets/confirmation_dialog.dart';

// Store
import 'package:todo_list/redux/actions.dart';
import 'package:todo_list/redux/store.dart';
import 'package:todo_list/redux/dispatch.dart';

// Utils
import 'package:todo_list/utils/todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({required this.index, required this.edit, Key? key}) : super(key: key);

  final int index;
  final void Function() edit;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Todo>(
      converter: (store) => store.state.todos[widget.index],
      builder: (BuildContext context, Todo todo) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('To-do'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: widget.edit,
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  showDialog(context: context, builder: (BuildContext context) {
                    return ConfirmationDialog(
                      confirmMessage: 'Delete',
                      onConfirm: () {
                        Navigator.pop(context);
                        dispatch(DeleteTodo(todo), context);
                      },
                    );
                  });
                },
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  todo.name,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}