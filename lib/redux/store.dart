import 'package:todo_list/utils/todo.dart';

class AppState {
  late List<Todo> todos = [Todo('Buy milk')];

  AppState({required this.todos});

  AppState.initial() {
    todos = [Todo('Buy milk')];
  }

  static AppState initialState() {
    List<Todo> initialTodos = [];
    return AppState(todos: initialTodos);
  }
}