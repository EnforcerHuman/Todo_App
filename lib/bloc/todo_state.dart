import 'package:todo/Model/todo_model.dart';

abstract class TodoState {
  final List<TodoModel> todos;
  TodoState({required this.todos});
}

class TodoInitial extends TodoState {
  TodoInitial() : super(todos: []);
}

class TodoLoading extends TodoState {
  TodoLoading() : super(todos: []);
}

class TodoLoaded extends TodoState {
  @override
  final List<TodoModel> todos;

  TodoLoaded(this.todos) : super(todos: todos);
}

class TodoError extends TodoState {
  final String message;

  TodoError(this.message) : super(todos: []);
}
