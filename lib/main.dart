import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_changenotifier/app.dart';
import 'package:todo_changenotifier/providers/todo_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => TodoProvider()..loadTodos(),
      ),
    ],
    child: const App(),
  ));
}
