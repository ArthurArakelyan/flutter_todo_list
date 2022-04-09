import 'package:http/http.dart' as http;

import 'package:todo_list/utils/todo.dart';

var todosUri = Uri.parse('http://jsonplaceholder.typicode.com/todos?_start=0&_limit=3');

Future<List<Todo>> fetchTodos() async {
  try {
    var response = await http.get(todosUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load todos.');
    }

    return todoListFromFetchJson(response.body);
  } catch(e) {
    throw Exception('Failed to load todos.');
  }
}