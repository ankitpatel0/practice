import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/api/provider/todo_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TodoProvider>(context,listen: false).getAllTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("GetApi Provider Screen")),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, value, child){
          if(value.isLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final todos =  value.todos;
          return ListView.builder(
             itemCount:todos.length,
              itemBuilder: (context,index){
               final todo = todos[index];
               return ListTile(
                 leading: CircleAvatar(
                   child: Text(todo.id.toString()),
                 ),
                 title: Text(todo.title,style: TextStyle(color: todo.completed?Colors.deepOrangeAccent:Colors.indigo),),
               );
              }
          );
        },
      ),
    );
  }
}
