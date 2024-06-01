import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Model/todo_model.dart';
import 'package:todo/Screens/add_todo.dart';
import 'package:todo/Services/api_services.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/bloc/todo_event.dart';
import 'package:todo/bloc/todo_state.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ApiServices apiservices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(apiservices)
        ..add(LoadTodos()), // Fetch todos on initialization
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              apiservices.getTodo();
              print('apiservices.gettodo');
              // context
              //     .read<TodoBloc>()
              //     .add(LoadTodos()); // Refresh data on button press
            },
            icon: const Icon(Icons.double_arrow_outlined),
          ),
        ),
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TodoLoaded) {
              return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text(state.todos[index].title),
                    subtitle: Text(state.todos[index].description),
                  );
                },
              );
            } else if (state is TodoError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(
                    MaterialPageRoute(builder: (ctx) => const AddTodoScreen()))
                .then((value) {
              if (value != null && value == true) {
                // Dispatch AddTodo event to refresh todos
                context.read<TodoBloc>().add(LoadTodos());
              }
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
