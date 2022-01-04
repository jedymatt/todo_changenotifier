import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_changenotifier/app.dart';
import 'package:todo_changenotifier/providers/todo_provider.dart';
import 'package:todo_changenotifier/storage/local_storage_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final LocalStorageRepository localStorage = LocalStorageRepository(
    rootKey: 'todo_changenotifier',
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => TodoProvider(
          repository: localStorage,
        )..loadTodos(),
      ),
    ],
    child: const App(),
  ));
}
