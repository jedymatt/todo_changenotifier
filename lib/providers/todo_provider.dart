import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_changenotifier/core/utils.dart';
import 'package:todo_changenotifier/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  UnmodifiableListView<Todo> get todos => UnmodifiableListView<Todo>(_todos);

  Future loadTodos() {
    _isLoading = true;
    notifyListeners();

    return Future.delayed(
      const Duration(milliseconds: 300),
    ).then((value) {
      final generatedTodos = List<Todo>.generate(
        20,
        (index) => Todo(
          id: uuidV4(),
          title: 'Todo No $index',
          description: '',
          isComplete: false,
        ),
      );
      _todos.addAll(generatedTodos);
      _isLoading = false;
      notifyListeners();
      return null;
    });
  }

  void addTodo(Todo todo) {
    _todos.add(todo.copyWith(id: uuidV4()));
    notifyListeners();
  }

  void updateTodo(Todo todo) {
    final index = _todos.indexWhere((element) => element.id == todo.id);
    _todos.replaceRange(index, index + 1, [todo]);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    final index = _todos.indexWhere((element) => element.id == todo.id);
    _todos.removeAt(index);
    notifyListeners();
  }

  void removeAll() {
    _todos.clear();
    notifyListeners();
  }

  Todo todoById(String id) {
    return _todos.firstWhere((element) => element.id == id);
  }
}
