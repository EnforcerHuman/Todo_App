import 'package:flutter/material.dart';
import 'package:todo/Services/api_services.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final ApiServices api = ApiServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          TextField(),
          SizedBox(
            height: 10,
          ),
          TextField(),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                api.submitdata('ASWIN', 'Brocamp');
              },
              child: Text('Submit'))
        ]),
      ),
    );
  }
}
