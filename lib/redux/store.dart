import 'package:todo_list/utils/todo.dart';

class AppState {
  late List<Todo> todos = [];
  bool todosLoading = false;
  bool todosError = false;

  AppState({required this.todos});

  AppState.initial() {
    todos = [];
    todosLoading = false;
    todosError = false;
  }

  AppState copyWith({List<Todo>? todos}) =>
    AppState(todos: todos ?? this.todos);

  static AppState fromJson(dynamic json) {
    if (json == null) {
      return AppState.initialState();
    }

    return AppState(
      todos: todoListFromJson(json['todos']),
    );
  }

  Map toJson () => {
    'todos': todoListToJson(todos),
  };

  static AppState initialState() {
    List<Todo> initialTodos = [];
    return AppState(todos: initialTodos);
  }
}