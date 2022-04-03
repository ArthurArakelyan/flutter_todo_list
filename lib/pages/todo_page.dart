import 'package:flutter/material.dart';

// Widgets
import 'package:todo_list/shared_widgets/confirmation_dialog.dart';

// Utils
import 'package:todo_list/utils/todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage(
    {
      required this.todo,
      required this.edit,
      required this.delete,
      Key? key
    }
  ) : super(key: key);

  final Todo todo;
  final void Function() edit;
  final void Function() delete;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
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
                  onConfirm: widget.delete,
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
              widget.todo.name,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),

          ],
        ),
      ),
    );
  }
}