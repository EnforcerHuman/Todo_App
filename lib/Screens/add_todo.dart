import 'package:flutter/material.dart';
import 'package:todo/Services/api_services.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
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
                api.submitdata('MELBIN', 'Brocamp');
              },
              child: Text('Submit'))
        ]),
      ),
    );
  }
}
