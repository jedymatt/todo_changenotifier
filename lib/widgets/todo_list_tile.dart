import 'package:flutter/material.dart';
import 'package:todo_changenotifier/models/todo.dart';
import 'package:todo_changenotifier/screens/edit_todo_screen.dart';

class TodoListTile extends StatefulWidget {
  // final String todoId;
  final Todo todo;
  final VoidCallback onDismissed;
  final Function(bool isComplete) onChanged;
  const TodoListTile({
    Key? key,
    required this.todo,
    required this.onDismissed,
    required this.onChanged,
  }) : super(key: key);

  @override
  _TodoListTileState createState() => _TodoListTileState();
}

class _TodoListTileState extends State<TodoListTile> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: widget.key ?? Key(widget.todo.id!),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) => widget.onDismissed(),
      child: ListTile(
        title: Text(
          widget.todo.title,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: widget.todo.description.isNotEmpty
            ? Text(
                widget.todo.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        leading: Checkbox(
          shape: const CircleBorder(),
          value: widget.todo.isComplete,
          checkColor: Colors.blue,
          activeColor: Colors.transparent,
          onChanged: (value) => widget.onChanged(value!),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTodoScreen(
                todo: widget.todo,
              ),
            ),
          );
        },
      ),
    );
  }
}
