import 'dart:convert';

import 'package:todo_assingment/constants/app_constant.dart';
import 'package:todo_assingment/data/model/todo_model.dart';
import 'package:http/http.dart' as http;

abstract class TodoRepository{
  Future <List<TodoModel>> getTodos();
}

class TodoRepositoryImpl implements TodoRepository{

  @override
  Future<List<TodoModel>> getTodos() async {
    var response= await http.get(AppConstants.base_url + "todos");
    if(response.statusCode == 200){
     // var data= json.decode(response.body) as List;
      //List<TodoModel> todos=  TodoModel.fromJson(data);

      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      List<TodoModel> todos=  parsed.map<TodoModel>((json) => TodoModel.fromJson(json)).toList();
      return todos;
    }
    else{
        throw Exception();
    }
  }

}