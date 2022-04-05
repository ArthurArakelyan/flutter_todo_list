import 'package:todo_list/redux/store.dart';

// Store
import 'actions.dart';
import 'store.dart';

AppState reducers(AppState prevState, dynamic action) {
  AppState state = AppState(todos: prevState.todos);

  if (action is AddTodo) {
    state.todos.insert(0, action.payload);
    return state;
  } else if (action is DeleteTodo) {
    state.todos.remove(action.payload);
    return state;
  } else if (action is EditTodo) {
    state.todos[action.index].name = action.name;

    return state;
  } else if (action is ToggleTodoDone) {
    var todo = state.todos[action.index];
    todo.done = !todo.done;

    return state;
  }

  return prevState;
}