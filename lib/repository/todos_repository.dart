import 'package:todo_changenotifier/models/models.dart';

abstract class TodosRepository {
  /// Load todos
  Future<List<Todo>> loadTodos();

  /// Persist todos
  Future saveTodos(List<Todo> todos);
}
