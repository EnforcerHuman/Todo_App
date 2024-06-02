import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Model/todo_model.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/bloc/todo_event.dart';

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
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('Add Todo')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
                context.read<TodoBloc>().add(
                    UpdateTodo(id: id, title: title, description: description));
              },
              child: Text('Add Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
