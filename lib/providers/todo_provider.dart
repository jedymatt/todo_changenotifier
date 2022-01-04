import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_changenotifier/core/constants.dart';
import 'package:todo_changenotifier/models/todo.dart';
import 'package:todo_changenotifier/repository/todos_repository.dart';

class TodoProvider extends ChangeNotifier {
  final TodosRepository repository;

  final List<Todo> _todos = [];
  bool _isLoading = false;

  TodoProvider({
    required this.repository,
  });

  bool get isLoading => _isLoading;
  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  Future<void> loadTodos() {
    _isLoading = true;
    notifyListeners();

    return repository.loadTodos().then((loadedTodos) {
      _todos.addAll(loadedTodos);
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
    });
  }

  void addTodo(Todo todo) {
    _todos.add(todo.copyWith(id: kUuid.v4()));
    notifyListeners();
    _uploadToRepository();
  }

  void updateTodo(Todo todo) {
    final index = _todos.indexWhere((element) => element.id == todo.id);
    _todos[index] = todo;
    // _todos.replaceRange(index, index + 1, [todo]);
    notifyListeners();
    _uploadToRepository();
  }

  void removeTodo(Todo todo) {
    // final index = _todos.indexWhere((element) => element.id == todo.id);
    // _todos.removeAt(index);
    _todos.remove(todo);
    notifyListeners();
    _uploadToRepository();
  }

  void removeAll() {
    _todos.clear();
    notifyListeners();
    _uploadToRepository();
  }

  Todo findTodoById(String id) {
    return _todos.firstWhere((element) => element.id == id);
  }

  void _uploadToRepository() {
    repository.saveTodos(todos);
  }
}
