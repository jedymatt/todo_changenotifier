import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_changenotifier/models/models.dart';
import 'package:todo_changenotifier/providers/todo_provider.dart';
import 'package:todo_changenotifier/widgets/todo_list_tile.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  @override
  Widget build(BuildContext context) {
    return Selector<TodoProvider, List<Todo>>(
      selector: (p0, p1) => p1.todos,
      shouldRebuild: (previous, next) => true,
      builder: (context, todos, child) {
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];

            return TodoListTile(
              todo: todo,
              onChanged: (isComplete) => updateTodo(
                todo: todo.copyWith(
                  isComplete: isComplete,
                ),
              ),
              onDismissed: () => removeTodo(
                todo: todo,
              ),
            );
          },
        );
      },
    );
  }

  void updateTodo({required Todo todo}) {
    context.read<TodoProvider>().updateTodo(todo);
  }

  void removeTodo({required Todo todo}) {
    context.read<TodoProvider>().removeTodo(todo);
  }
}
