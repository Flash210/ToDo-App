
import 'package:dio/dio.dart';
import 'package:ret_training/data/todo_model.dart';
import 'package:retrofit/http.dart';

part 'web_service.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class WebsService{
  factory WebsService(Dio dio,{String baseUrl}) =_WebsService;


@GET("todos")
Future<List<TodoModel>> getAllTodos();

}