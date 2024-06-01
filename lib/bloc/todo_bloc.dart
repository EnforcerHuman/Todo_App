import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:todo/Services/api_services.dart';
import 'package:todo/bloc/todo_event.dart';
import 'package:todo/bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ApiServices apiServices;

  TodoBloc(this.apiServices) : super(TodoInitial()) {
    on<LoadTodos>((event, emit) async {
      emit(TodoLoading());
      try {
        final todos = await apiServices.getTodo();
        if (todos != null) {
          emit(TodoLoaded(todos));
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
      emit(TodoLoading());
      try {
        await apiServices.submitdata(event.title, event.description);
        final todos = await apiServices.getTodo();
        if (todos != null) {
          emit(TodoLoaded(todos));
        } else {
          emit(TodoError('Failed to reload todos after adding'));
        }
      } on SocketException catch (e) {
        emit(TodoError('Network error: $e'));
      } catch (e) {
        emit(TodoError('An error occurred: $e'));
      }
    });
  }
}
