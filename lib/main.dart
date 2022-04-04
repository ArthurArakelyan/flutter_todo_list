import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

// Pages
import 'package:todo_list/pages/home.dart';

// Store
import 'package:todo_list/redux/reducers.dart';
import 'package:todo_list/redux/store.dart';

void main() async {
  final persistor = Persistor<AppState>(
    storage: FlutterStorage(),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  WidgetsFlutterBinding.ensureInitialized();
  final initialState = await persistor.load();

  final store = Store<AppState>(
    reducers,
    initialState: initialState ?? AppState.initialState(),
    middleware: [persistor.createMiddleware()],
  );

  runApp(App(store: store));
}

class App extends StatelessWidget {
  final Store<AppState> store;

  const App({required this.store, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.deepOrange,
          primarySwatch: Colors.deepOrange,
        ),
        home: const Home(),
      ),
    );
  }
}