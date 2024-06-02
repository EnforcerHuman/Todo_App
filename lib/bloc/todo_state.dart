import 'package:todo/Model/todo_model.dart';

abstract class TodoState {
  final List<TodoModel> todos;
  TodoState({required this.todos});
}

class TodoInitial extends TodoState {
  TodoInitial() : super(todos: const []);
}

class TodoLoading extends TodoState {
  TodoLoading({required super.todos});
}

class TodoLoaded extends TodoState {
  TodoLoaded({required super.todos});
}

class TodoError extends TodoState {
  final String message;

  TodoError(this.message) : super(todos: []);
}
