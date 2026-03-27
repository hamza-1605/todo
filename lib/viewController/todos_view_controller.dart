import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/local/app_db.dart';
import 'package:todo/model/todo_model.dart';

class TodosViewController extends ChangeNotifier {
  final AppDatabase appDb;
  TodosViewController({required this.appDb});

  List<TodoModel> todos = [];
  bool isLoading = false;
  String? error;

  StreamSubscription? _sub;
  
  @override 
  void dispose() {
    _sub?.cancel(); 
    super.dispose(); 
  }

  void listenTodos(){
    isLoading = true;
    notifyListeners();

    _sub = appDb.watchTodos().listen(                 // listens to the stream (of list of Todo from Drift-Class) and then maps them to the ToDo Model. 
      (data) {            
        todos = data.reversed.map( (element) => TodoModel(
          id: element.id, 
          title: element.title, 
          isCompleted: element.isCompleted
        )).toList();
        
        isLoading = false;
        notifyListeners();
      }, 
      onError: (e) {
        error = e.toString();
        isLoading = false;
        notifyListeners();
      });
  }


  Future<void> createTodo( String title ) async{                      // adding in db
    await appDb.insertTodo( TodosCompanion( title: Value(title) ));      
  }


  Future<void> removeTodo( int id ) async{                           // deleting from db
    await appDb.deleteTodo(id);                                         
  }


  Future<void> toggleTodo( int id ) async{
    final todo = todos.firstWhere( (t) => t.id == id);     // finding the todo with its id
    final toggledValue = ! todo.isCompleted;              // getting the updated value
    
    await appDb.toggleTodo(id, toggledValue);            // Updating in the db
  }

}



  // Future<void> getTodos() async{
  //   isLoading = true;
  //   notifyListeners();

  //   try {
  //     final data = await appDb.getTodos();

  //     final modelData = data.map( (element) => TodoModel(    // converting it into our model-friendly data
  //       id: element.id, 
  //       title: element.title, 
  //       isCompleted: element.isCompleted
  //     )).toList();

  //     todos = modelData.reversed.toList();
  //   } 
  //   catch (e) {
  //     error = e.toString();  
  //   }

  //   isLoading = false;
  //   notifyListeners();
  // }