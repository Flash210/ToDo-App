part of 'my_cubit.dart';

@immutable
sealed class MyState {}

final class MyInitial extends MyState {}

class GetAllTodos extends MyState {
  final List<TodoModel> allTodosList;

  GetAllTodos(this.allTodosList);
}

class AddTodoSuccess extends MyState {
  final TodoModel addedTodo;

  AddTodoSuccess(this.addedTodo);
}

class UpdateTodoSuccess extends MyState {
  final TodoModel updatedTodo;

  UpdateTodoSuccess(this.updatedTodo);
}

class DeleteTodoSuccess extends MyState {
  final int deletedTodoId;

  DeleteTodoSuccess(this.deletedTodoId);
}
