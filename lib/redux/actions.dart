import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:todo_list/redux/store.dart';

import 'package:todo_list/services/todo_service.dart';

import 'package:todo_list/utils/todo.dart';

ThunkAction<AppState> fetchTodosAction() {
  return (Store<AppState> store) async {
    if (store.state.todos.isNotEmpty) {
      return;
    }

    store.dispatch(StartFetchingTodos());

    try {
      var todos = await fetchTodos();
      store.dispatch(SuccessfullyFetchedTodos(todos));
    } catch(e) {
      store.dispatch(ErrorFetchedTodos());
    }
  };
}

class StartFetchingTodos {
  StartFetchingTodos();
}

class SuccessfullyFetchedTodos {
  List<Todo> payload;

  SuccessfullyFetchedTodos(this.payload);
}

class ErrorFetchedTodos {
  ErrorFetchedTodos();
}

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
