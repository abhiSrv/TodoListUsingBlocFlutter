import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable{
}

class FetchTodoEvent extends TodoEvent{

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}