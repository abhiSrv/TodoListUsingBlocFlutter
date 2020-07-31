import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assingment/bloc/todo_bloc/todo_bloc.dart';
import 'package:todo_assingment/bloc/todo_bloc/todo_events.dart';
import 'package:todo_assingment/bloc/todo_bloc/todo_state.dart';
import 'package:todo_assingment/data/model/todo_model.dart';
import 'package:todo_assingment/data/repositories/todo_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context)=> TodoBloc(repository: TodoRepositoryImpl()),
        child: MyHomePage(),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  TodoBloc _todoBloc;
  @override
  void initState() {
    super.initState();
    _todoBloc= BlocProvider.of<TodoBloc>(context);
    _todoBloc.add(FetchTodoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo List"),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              // navigateToAboutPage();
              _todoBloc.add(FetchTodoEvent());
            },
          ),
        ],
      ),
      body:Container(
          child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state){
            if(state is TodoInitialState){
              return buildLoading();
            }else if(state is TodoLoadingState){
              return buildLoading();
            }else if(state is TodoLoadedState){
              return buildTodoListUi(state.todos);
            }else if(state is TodoErrorState){
              return buildErrorUi(state.message);
            }
          },
        ),
      ) ,
    );
  }

  Widget buildLoading(){
    return Scaffold(
        body: Center(
        child: SizedBox(
            width: 40.0,
            height: 40.0,
            child: CircularProgressIndicator(),
          )
       )
    );
  }

  Widget buildErrorUi(String errorMessage){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Something went wrong",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Give it another try",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
          FlatButton(
            child: Text(
              "RELOAD",
              style: TextStyle(
                  color: Colors.blue, fontSize: 15.0),
            ),
            onPressed: ()=> _todoBloc.add(FetchTodoEvent()),
          )
        ],
      ),
    );

  }

 Widget buildTodoListUi(List<TodoModel> todos){
    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (ctx, pos){
          var todo= todos[pos];
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: todo.completed ? Colors.green : Colors.red,
                child: Text(
                  todo.id.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
               title: Text(todo.title,),
               subtitle:Text(todo.completed.toString()) ,
              ),
            );
        }
    );
 }


}