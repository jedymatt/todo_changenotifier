import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_changenotifier/models/models.dart';
import 'package:todo_changenotifier/providers/todo_provider.dart';

class EditTodoScreen extends StatefulWidget {
  final Todo todo;
  const EditTodoScreen({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  _EditTodoScreenState createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.todo.title;
    _descriptionController.text = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update todo'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<TodoProvider>().removeTodo(widget.todo);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: ListView(
        children: [
          TextFormField(
            controller: _titleController,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Title',
              contentPadding: EdgeInsets.all(10.0),
            ),
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              contentPadding: EdgeInsets.all(10.0),
            ),
            maxLines: null,
          ),
        ],
      ),
    );
  }
}
