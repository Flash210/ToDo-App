part of 'my_cubit.dart';

@immutable
sealed class MyState {}

final class MyInitial extends MyState {}

class GetAllTodos extends MyState {
  final List<TodoModel> allTodosList;

  GetAllTodos(this.allTodosList);
}
