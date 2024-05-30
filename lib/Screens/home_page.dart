import 'package:flutter/material.dart';
import 'package:todo/Model/todo_model.dart';
import 'package:todo/Screens/add_todo.dart';
import 'package:todo/Services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoModel? todo;
  ApiServices apiservices = ApiServices();

  @override
  void initState() {
    super.initState();
    Fetchtodo(); // Call Fetchtodo on init
  }

  Future<void> Fetchtodo() async {
    todo = await apiservices.getTodo();
    setState(() {}); // Rebuild UI after fetching data
  }

  @override
  Widget build(BuildContext context) {
    // Handle potential null case for todo
    if (todo == null) {
      return const Center(
          child: CircularProgressIndicator()); // Show loading indicator
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Fetchtodo(); // Call Fetchtodo to refresh data on button press
          },
          icon: const Icon(Icons.double_arrow_outlined),
        ),
      ),
      body: ListView.builder(
        itemCount: todo?.items.length ?? 0, // Handle null case for todo.items
        itemBuilder: (ctx, index) {
          return ListTile(
            title: Text(
                todo!.items[index].title), // Use null-safe access operator (!)
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const AddTodo()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
