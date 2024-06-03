import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Model/todo_model.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/bloc/todo_event.dart';
import 'package:todo/bloc/todo_state.dart';

class EditScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String id;
  const EditScreen(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.id});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: title);
    final descriptionController = TextEditingController(text: subtitle);
    return Scaffold(
      appBar: AppBar(title: Text('Edit Todo')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is TodoLoading) {
              // Show loading dialog
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  title: Text('Saving...'),
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 20),
                      Text('Please wait'),
                    ],
                  ),
                ),
              );
            } else if (state is TodoLoaded) {
              Navigator.of(context).pop();
              Navigator.of(context).pop(true);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Todo Edited successfully')),
              );
            } else if (state is TodoError) {
              Navigator.of(context).pop(); // Close the loading dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final title = titleController.text;
                  final description = descriptionController.text;
                  context.read<TodoBloc>().add(UpdateTodo(
                      id: id, title: title, description: description));
                },
                child: Text('SUBMIT'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
