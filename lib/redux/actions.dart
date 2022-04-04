import 'package:todo_list/utils/todo.dart';

class AddTodo {
  Todo payload;

  AddTodo(this.payload);
}

class EditTodo {
  String id;
  String name;

  EditTodo(this.id, this.name);
}

class DeleteTodo {
  Todo payload;

  DeleteTodo(this.payload);
}

class ToggleTodoDone {
  String id;

  ToggleTodoDone(this.id);
}
