import 'package:todo_list/utils/todo.dart';

class AddTodo {
  Todo payload;

  AddTodo(this.payload);
}

class EditTodo {
  int index;
  String name;

  EditTodo(this.index, this.name);
}

class DeleteTodo {
  Todo payload;

  DeleteTodo(this.payload);
}

class ToggleTodoDone {
  int index;

  ToggleTodoDone(this.index);
}
