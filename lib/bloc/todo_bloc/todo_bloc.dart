import 'package:bloc/bloc.dart';
import 'package:todo_assingment/bloc/todo_bloc/todo_events.dart';
import 'package:todo_assingment/bloc/todo_bloc/todo_state.dart';
import 'package:todo_assingment/data/model/todo_model.dart';
import 'package:todo_assingment/data/repositories/todo_repository.dart';
import 'package:meta/meta.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState>{
  TodoRepository repository;

  TodoBloc({@required this.repository});

  @override
  TodoState get initialState => TodoInitialState();

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async*{
    if(event is FetchTodoEvent){
      yield TodoLoadingState();
      try {
        List<TodoModel> todos = await repository.getTodos();
        yield TodoLoadedState(todos: todos);
      }catch(e){
        yield TodoErrorState(message: e.toString());
      }
    }
  }

   
}