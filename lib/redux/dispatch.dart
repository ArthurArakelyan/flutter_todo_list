import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_list/redux/store.dart';

void dispatch(dynamic action, context) {
  StoreProvider.of<AppState>(context)
    .dispatch(action);
}