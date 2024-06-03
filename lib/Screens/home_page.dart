// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:todo/Screens/add_todo.dart';
// import 'package:todo/Screens/detil_page.dart';
// import 'package:todo/Services/api_services.dart';
// import 'package:todo/Widgets/task_widget.dart';
// import 'package:todo/bloc/todo_bloc.dart';
// import 'package:todo/bloc/todo_event.dart';
// import 'package:todo/bloc/todo_state.dart';

// class HomeScreen extends StatelessWidget {
//   HomeScreen({super.key});

//   final ApiServices apiservices = ApiServices();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Center(child: Text('To-Do')),
//         leading: IconButton(
//           onPressed: () {
//             // context.read<TodoBloc>().add(LoadTodos());
//             context.watch<TodoBloc>().add(LoadTodos());
//           },
//           icon: const Icon(Icons.double_arrow_outlined),
//         ),
//       ),
//       body: BlocConsumer<TodoBloc, TodoState>(
//         listener: (context, state) {
//           if (state is TodoError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.message)),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is TodoLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is TodoLoaded) {
//             return GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 mainAxisSpacing: 4.0,
//                 crossAxisSpacing: 4.0,
//               ),
//               itemCount: state.todos.length,
//               itemBuilder: (ctx, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (ctx) => DetailedScreen(index: index),
//                       ),
//                     );
//                   },
//                   child: TaskWidget(
//                     title: state.todos[index].title,
//                     subtitle: state.todos[index].description,
//                     id: state.todos[index].id,
//                     index: index,
//                   ),
//                 );
//               },
//             );
//           } else if (state is TodoError) {
//             return Center(child: Text(state.message));
//           } else {
//             return const Center(child: Text('Unknown state'));
//           }
//         },
//       ),
//       floatingActionButton: ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).push(
//                 MaterialPageRoute(builder: (ctx) => const AddTodoScreen()));
//           },
//           child: Text('Add New Task')),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Screens/add_todo.dart';
import 'package:todo/Screens/detil_page.dart';
import 'package:todo/Services/api_services.dart';
import 'package:todo/Widgets/task_widget.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/bloc/todo_event.dart';
import 'package:todo/bloc/todo_state.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ApiServices apiservices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text('To-Do')),
        leading: IconButton(
          onPressed: () {
            context.read<TodoBloc>().add(LoadTodos());
          },
          icon: const Icon(Icons.double_arrow_outlined),
        ),
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is TodoLoaded) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }
        },
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
              itemCount: state.todos.length,
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => DetailedScreen(index: index),
                      ),
                    );
                  },
                  child: TaskWidget(
                    title: state.todos[index].title,
                    subtitle: state.todos[index].description,
                    id: state.todos[index].id,
                    index: index,
                  ),
                );
              },
            );
          } else if (state is TodoError) {
            return Center(child: Text(state.message));
          } else {
            return Text('');
          }
        },
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AddTodoScreen()));
          },
          child: Text('Add New Task')),
    );
  }
}
