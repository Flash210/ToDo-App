import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ret_training/data/todo_model.dart';
import 'package:ret_training/repository/my_repository.dart';

part 'my_state.dart';

class MyCubit extends Cubit<MyState> {
  final MyRepository repository;
  MyCubit(this.repository) : super(MyInitial());

  void emitGetAllUsers() {
    repository.getAllTodos().then((todoList) {
      emit(GetAllTodos(todoList));
    });
  }
}
