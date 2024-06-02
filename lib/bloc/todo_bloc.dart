import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:todo/Services/api_services.dart';
import 'package:todo/bloc/todo_event.dart';
import 'package:todo/bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ApiServices apiServices;

  TodoBloc(this.apiServices) : super(TodoInitial()) {
    on<LoadTodos>((event, emit) async {
      emit(TodoLoading(todos: []));
      try {
        final todos = await apiServices.getTodo();
        if (todos != null) {
          emit(TodoLoaded(todos: todos));
        } else {
          emit(TodoError('Failed to load todos now'));
        }
      } on SocketException catch (e) {
        emit(TodoError('Network error: $e'));
      } catch (e) {
        emit(TodoError('An error occurred: $e'));
      }
    });

    on<AddTodo>((event, emit) async {
      final currentstate = state;
      print(currentstate.todos);
      emit(currentstate);
      try {
        await apiServices.submitdata(event.title, event.description);
        final todos = await apiServices.getTodo();
        if (todos != null) {
          emit(TodoLoaded(todos: todos));
        } else {
          emit(TodoError('Failed to reload todos after adding'));
        }
      } on SocketException catch (e) {
        emit(TodoError('Network error: $e'));
      } catch (e) {
        emit(TodoError('An error occurred: $e'));
      }
    });

    //On delete

    on<DeleteTodo>((event, emit) async {
      final currentstate = state;
      try {
        await apiServices.deletetodo(event.id);
        final todos = await apiServices.getTodo();
        if (todos != null) {
          emit(TodoLoaded(todos: todos));
        } else {
          emit(TodoError('Failed to delete data'));
        }
      } on SocketException catch (e) {
        emit(TodoError('Network error: $e'));
      } catch (e) {
        emit(TodoError('An error occurred: $e'));
      }
    });

    on<UpdateTodo>(
      (event, emit) async {
        final currentstate = state;
        emit(TodoLoading(todos: currentstate.todos));
        try {
          await apiServices.updatetodo(
              event.id, event.title, event.description);
          final todos = await apiServices.getTodo();
          if (todos != null) {
            emit(TodoLoaded(todos: todos));
          } else {
            print('unable to update todos');
          }
        } on SocketException catch (e) {
          emit(TodoError('Network error: $e'));
        } catch (e) {
          emit(TodoError('An error occurred: $e'));
        }
      },
    );
  }
}
