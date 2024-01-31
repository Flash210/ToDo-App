
import 'package:dio/dio.dart';
import 'package:ret_training/data/todo_model.dart';
import 'package:retrofit/http.dart';

part 'web_service.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class WebsService{
  factory WebsService(Dio dio,{String baseUrl}) =_WebsService;


@GET("todos")
Future<List<TodoModel>> getAllTodos();


 @POST("add")
  Future<TodoModel> addTodo(@Body() TodoModel todo);

  @PUT("put/todos/{id}")
  Future<TodoModel> updateTodo(
      @Path("id") int id, @Body() TodoModel updatedTodo);

  @DELETE("delete/todos/{id}")
  Future<void> deleteTodo(@Path("id") int id);

}