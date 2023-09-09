import 'package:flutter/cupertino.dart';
import '../model/test_model.dart';
import '../services/todo_services.dart';

class TodoProvider with ChangeNotifier {
  final _services = TodoServices();
  bool isLoading = false;
  List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;

  Future<void> getAllTodos()async{
    isLoading = true;
    notifyListeners();

    final response = await _services.getAll();
    _todos = response;
    isLoading = false;
    notifyListeners();
  }

}