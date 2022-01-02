import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_changenotifier/models/models.dart';
import 'package:todo_changenotifier/providers/todo_provider.dart';
import 'package:todo_changenotifier/screens/edit_todo_screen.dart';

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
      shouldRebuild: (previous, next) {
        log('previous: $previous');
        log('next: $next');
        log('previous == next: ${previous == next}');
        log('previous.length: ${previous.length}, next.length: ${next.length}');
        return false;
      },
      builder: (context, todos, child) {
        return ListView.builder(
          key: const Key('__todoList__'),
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];

            return Dismissible(
              key: ValueKey(todo),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (direction) {
                context.read<TodoProvider>().removeTodo(todo);
              },
              child: ListTile(
                title: Text(todo.title),
                subtitle: todo.description.isNotEmpty
                    ? Text(
                        todo.description,
                        maxLines: 1,
                      )
                    : null,
                leading: Checkbox(
                  value: todo.isComplete,
                  onChanged: (value) {
                    context.read<TodoProvider>().updateTodo(
                          todo.copyWith(
                            isComplete: value!,
                          ),
                        );
                  },
                ),
                onTap: () {
                  // todo: Navigate to todo update screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTodoScreen(
                        todo: todo,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
