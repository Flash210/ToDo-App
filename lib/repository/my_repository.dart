

import 'package:ret_training/data/todo_model.dart';
import 'package:ret_training/webService/web_service.dart';

class MyRepository{


final WebsService websService;

MyRepository(this.websService);

Future<List<TodoModel>> getAllTodos()async{
  var response=await websService.getAllTodos();
  return response.map((todoObject) => TodoModel.fromJson(todoObject.toJson())).toList();

}


}