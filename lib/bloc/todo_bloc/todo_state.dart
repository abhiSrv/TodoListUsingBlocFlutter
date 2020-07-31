import 'package:equatable/equatable.dart';
import 'package:todo_assingment/data/model/todo_model.dart';
import 'package:meta/meta.dart';

abstract class TodoState extends Equatable{}

class TodoInitialState extends TodoState{
  @override
  List<Object> get props => [];
}

class TodoLoadingState extends TodoState{
  @override
  List<Object> get props => [];
}

class TodoLoadedState extends TodoState{
  List<TodoModel> todos;
  TodoLoadedState({@required this.todos} );

  @override
  List<Object> get props => throw UnimplementedError();
}

class TodoErrorState extends TodoState{
  String message;

  TodoErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}