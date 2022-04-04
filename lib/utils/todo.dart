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

  static Todo fromJson(Map<String, dynamic> map) {
    var id = map['id'];
    var name = map['name'];
    var done = map['done'];

    return Todo(name, done, id);
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