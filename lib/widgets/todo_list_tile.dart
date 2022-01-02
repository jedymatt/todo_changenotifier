import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_changenotifier/models/todo.dart';
import 'package:todo_changenotifier/providers/todo_provider.dart';
import 'package:todo_changenotifier/screens/edit_todo_screen.dart';

class TodoListTile extends StatefulWidget {
  final String todoId;
  const TodoListTile({
    Key? key,
    required this.todoId,
  }) : super(key: key);

  @override
  _TodoListTileState createState() => _TodoListTileState();
}

class _TodoListTileState extends State<TodoListTile> {
  @override
  Widget build(BuildContext context) {
    return Selector<TodoProvider, Todo>(
      selector: (p0, p1) => p1.todoById(widget.todoId),
      builder: (context, todo, child) {
        return ListTile(
          key: ValueKey(todo),
          title: Text(todo.title),
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditTodoScreen(
                  todo: todo,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
