import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:todo/Model/todo_model.dart';

class ApiServices {
  Future<void> submitdata(String title, String description) async {
    final body = {
      "title": title,
      "description": description,
      "is_completed": true
    };

    const url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    print(response.statusCode);
  }

  // Future<void> getTodo() async {
  //   final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
  //   final uri = Uri.parse(url);
  //   final response = await http.get(uri);
  //   print(response.statusCode);
  //   TodoModel todomodel = TodoModel.fromJson(jsonDecode(response.body));
  //   print(todomodel);
  // }

  Future<TodoModel?> getTodo() async {
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final todomodel = TodoModel.fromJson(jsonDecode(response.body));
        TodoModel todo = todomodel;

        return todomodel;
      } else {
        // Handle unsuccessful response (e.g., print error message)
        print('Error getting todos: Status code ${response.statusCode}');
        return null; // Or throw an exception if appropriate
      }
    } on SocketException catch (e) {
      // Handle socket exceptions (e.g., connection reset)
      print('Socket error: $e');
      return null; // Or throw a specific exception for handling
    } catch (e) {
      // Handle other exceptions (e.g., decoding errors)
      print('Error: $e');
      return null; // Or throw a generic exception
    }
  }
}
