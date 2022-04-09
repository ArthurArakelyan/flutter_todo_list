import 'package:flutter/material.dart';
import 'dart:convert';

class Todo {
  String id = UniqueKey().toString();
  String name;
  bool done;

  Todo(this.name, [this.done = false, id]) {
    if (id != null) {
      this.id = id;
    }
  }

  Map<String, dynamic> toJSON () => {
    'id': id,
    'name': name,
    'done': done,
  };

  static Todo fromJson(Map<String, dynamic> json) {
    var id = json['id'];
    var name = json['name'];
    var done = json['done'];

    return Todo(name, done, id);
  }

  static Todo fromFetchJson(Map<String, dynamic> json) {
    return Todo(
      json['title'],
      json['completed'],
    );
  }
}

todoListToJson(List<Todo> todos) {
  return jsonEncode(todos.map((todo) => todo.toJSON()).toList());
}

List<Todo> todoListFromJson(String json) {
  List items = jsonDecode(json);
  List<Todo> todos = [];

  for (var todo in items) {
    todos.add(Todo.fromJson(todo));
  }

  return todos;
}

List<Todo> todoListFromFetchJson(String json) {
  List items = jsonDecode(json);
  List<Todo> todos = [];

  for (var todo in items) {
    todos.add(Todo.fromFetchJson(todo));
  }

  return todos;
}