import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_changenotifier/models/todo.dart';
import 'package:todo_changenotifier/repository/todos_repository.dart';

class LocalStorage extends TodosRepository {
  final String rootKey;
  final String todosKey = 'todos';
  final JsonCodec codec = json;

  LocalStorage({
    required this.rootKey,
  });

  @override
  Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final root = prefs.getString(rootKey);

    final decodedTodos = json.decode(root!)[todosKey];
    return decodedTodos
        .cast<Map<String, dynamic>>()
        .map<Todo>((Todo.fromJson))
        .toList();
  }

  @override
  Future<bool> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(
      rootKey,
      codec.encode({
        todosKey: todos.map((e) => e.toJson()).toList(),
      }),
    );
  }
}
