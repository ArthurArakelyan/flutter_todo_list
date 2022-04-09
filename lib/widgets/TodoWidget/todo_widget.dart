import 'package:flutter/material.dart';

// Pages
import 'package:todo_list/pages/todo_page.dart';

// Widgets
import 'package:todo_list/widgets/TodoWidget/todo_edit_modal.dart';

// Store
import 'package:todo_list/redux/actions.dart';
import 'package:todo_list/redux/dispatch.dart';

// Utils
import 'package:todo_list/utils/todo.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget(
    {
      required this.todo,
      required this.index,
      Key? key
    }
  ) : super(key: key);

  final Todo todo;
  final int index;

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
      dispatch(EditTodo(widget.index, editValue), context);
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
                index: widget.index,
                edit: showEditModal,
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
                  dispatch(ToggleTodoDone(widget.index), context);
                },
              ),
            ],
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            dispatch(DeleteTodo(widget.todo), context);
          },
          icon: const Icon(Icons.delete_outline),
        ),
      ),
    );
  }
}