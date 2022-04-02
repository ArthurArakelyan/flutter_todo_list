import 'package:flutter/material.dart';

class TodoEditModal extends StatefulWidget {
  const TodoEditModal({required this.initialValue, required this.handleChange, required this.closeDialog, required this.submitDialog, Key? key}) : super(key: key);

  final String initialValue;
  final void Function(String value) handleChange;
  final void Function() closeDialog;
  final void Function() submitDialog;

  @override
  State<TodoEditModal> createState() => _TodoEditModalState();
}

class _TodoEditModalState extends State<TodoEditModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Todo'),
      content: TextFormField(
        initialValue: widget.initialValue,
        onChanged: widget.handleChange,
        autofocus: true,
      ),
      actions: [
        ElevatedButton(
          onPressed: widget.closeDialog,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: widget.submitDialog,
          child: const Text('Edit'),
        ),
      ],
    );
  }
}