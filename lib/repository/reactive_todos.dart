import 'package:todo_changenotifier/models/models.dart';

abstract class ReactiveTodosRepository {
  Future<void> addTodo(Todo todo);

  Future<void> deleteTodos(List<String> todoIds);

  Stream<List<Todo>> todos();

  Future<void> updateTodo(Todo todo);
}
