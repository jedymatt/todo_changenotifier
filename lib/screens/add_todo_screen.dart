import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_changenotifier/models/todo.dart';
import 'package:todo_changenotifier/providers/todo_provider.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add todo'),
        actions: [
          IconButton(
            onPressed: () {
              final todo = Todo(
                title: _titleController.text,
                description: _descriptionController.text,
                isComplete: false,
                id: '',
              );
              context.read<TodoProvider>().addTodo(todo);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.add),
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
