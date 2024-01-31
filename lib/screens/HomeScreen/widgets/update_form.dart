import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ret_training/busnisses_logic/cubit/my_cubit.dart';
import 'package:ret_training/data/todo_model.dart';

class UpdateTodoForm extends StatefulWidget {
  @override
  _UpdateTodoFormState createState() => _UpdateTodoFormState();
}

class _UpdateTodoFormState extends State<UpdateTodoForm> {
  late TextEditingController idController;
  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    titleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: 'ID'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
    try {
      // Update the todo item
      final updatedId = int.parse(idController.text);
      final updatedTitle = titleController.text;
      final updatedTodo = TodoModel(id: updatedId, title: updatedTitle);
      // Use Cubit to update the todo item
      BlocProvider.of<MyCubit>(context).updateTodo(updatedId, updatedTodo);
      // Navigate back to the previous screen
      Navigator.pop(context);
    } catch (e) {
      // Handle errors here
      print('Error updating todo: $e');
      // You can show a snackbar or dialog to inform the user about the error
    }
  },
  child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    idController.dispose();
    titleController.dispose();
    super.dispose();
  }
}
