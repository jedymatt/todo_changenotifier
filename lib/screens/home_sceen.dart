import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_changenotifier/providers/todo_provider.dart';
import 'package:todo_changenotifier/screens/add_todo_screen.dart';
import 'package:todo_changenotifier/widgets/todo_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: Selector<TodoProvider, bool>(
          selector: (p0, p1) => p1.isLoading,
          builder: (context, isLoading, child) {
            if (isLoading) {
              return _buildLoading();
            }

            return _buildLoaded();
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTodoScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildLoaded() {
    return const TodoListView();
  }
}
