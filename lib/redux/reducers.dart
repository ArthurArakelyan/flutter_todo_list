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
  } else if (action is StartFetchingTodos) {
    state.todosLoading = true;
    state.todosError = false;
    return state;
  } else if (action is SuccessfullyFetchedTodos) {
    state.todos = action.payload;
    state.todosLoading = false;
    state.todosError = false;
    return state;
  } else if (action is ErrorFetchedTodos) {
    state.todosLoading = false;
    state.todosError = true;
    return state;
  }

  return prevState;
}