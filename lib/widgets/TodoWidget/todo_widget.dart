import 'package:flutter/material.dart';

// Pages
import 'package:todo_list/pages/todo_page.dart';

// Widgets
import 'package:todo_list/widgets/TodoWidget/todo_edit_modal.dart';

// Utils
import 'package:todo_list/utils/todo.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget(
    {
      required this.todo,
      required this.deleteTodo,
      required this.toggleTodoDone,
      required this.editTodo,
      Key? key
    }
  ) : super(key: key);

  final Todo todo;
  final void Function(Todo todo) deleteTodo;
  final void Function(Todo todo) toggleTodoDone;
  final void Function(Todo todo, String name) editTodo;

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  String editValue = '';

  void closeDialog(BuildContext dialog) {
    Navigator.pop(dialog);
    editValue = '';
  }

  void submitDialog(BuildContext dialog) {
    if (editValue != '' || (editValue != widget.todo.name && editValue != '')) {
      widget.editTodo(widget.todo, editValue);
    }

    closeDialog(dialog);
  }

  void showEditModal() {
    showDialog(context: context, builder: (BuildContext dialog) {
      return TodoEditModal(
        initialValue: widget.todo.name,
        handleChange: (String value) => editValue = value,
        closeDialog: () => closeDialog(dialog),
        submitDialog: () => submitDialog(dialog),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(widget.todo.id),
      child: ListTile(
        title: InkWell(
          onLongPress: showEditModal,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TodoPage(
                todo: widget.todo,
                edit: showEditModal,
                delete: () {
                  widget.deleteTodo(widget.todo);
                  Navigator.pop(context);
                },
              )),
            );
          },
          child: Row(
            children: [
              Text(
                widget.todo.name,
                style: TextStyle(
                  decoration: widget.todo.done ? TextDecoration.lineThrough : TextDecoration.none,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Checkbox(
                value: widget.todo.done,
                onChanged: (bool? value) {
                  widget.toggleTodoDone(widget.todo);
                },
              ),
            ],
          ),
        ),
        trailing: IconButton(
          onPressed: () => widget.deleteTodo(widget.todo),
          icon: const Icon(Icons.delete_outline),
        ),
      ),
    );
  }
}