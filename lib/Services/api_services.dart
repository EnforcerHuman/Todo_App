import 'dart:convert';
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
    if (response.statusCode != 201) {
      throw Exception('Failed to add todo');
    }
  }

  Future<List<TodoModel>?> getTodo() async {
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> jsonList = jsonResponse['items'];
        print(jsonList);
        final List<TodoModel> todos =
            jsonList.map((json) => TodoModel.fromJson(json)).toList();
        return todos;
      } else {
        print('Error getting todos: Status code ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error parsing : $e');
      return null;
    }
  }

  Future<void> deletetodo(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      print('deleted successfully');
    }
  }

  Future<void> updatetodo(String id, String title, String description) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final body = {
      "title": title,
      "description": description,
      "is_completed": true
    };
    final response = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    print(response.statusCode);
  }
}
