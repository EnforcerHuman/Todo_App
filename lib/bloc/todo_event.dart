abstract class TodoEvent {}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  final String description;

  AddTodo(this.title, this.description);
}

class DeleteTodo extends TodoEvent {
  final String id;

  DeleteTodo({required this.id});
}

class UpdateTodo extends TodoEvent {
  final String id;
  final String title;
  final String description;

  UpdateTodo(
      {required this.id, required this.title, required this.description});
}
