import 'package:flutter/material.dart';

class Todo {
  String id = UniqueKey().toString();
  String name;
  bool done = false;

  Todo(this.name);
}