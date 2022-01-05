import 'package:todo_changenotifier/models/models.dart';

abstract class ReactiveTodosRepository {
  Future addTodo(Todo todo);

  Future deleteTodos(List<String> todoIds);

  Stream<List<Todo>> todos();

  Future updateTodo(Todo todo);
}
