import 'package:flutter/material.dart';
import 'package:todo/data/local/app_db.dart';
import 'package:todo/view/add_todo_dialog.dart';
import 'package:todo/viewController/todos_view_controller.dart';
import 'package:provider/provider.dart';

class TodosView extends StatelessWidget {
  const TodosView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodosViewController(
        appDb: context.read<AppDatabase>(),
      )..listenTodos(),

      child: Scaffold(
        appBar: AppBar(
          title: Text('ToDo List', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25)),
          centerTitle: true,
        ),

        body: Consumer<TodosViewController>(
          builder: (context, todosVC, child) {
            if(todosVC.isLoading){
              return Center(child: CircularProgressIndicator(),);
            }
            if(todosVC.error != null){
              return centerText( todosVC.error! );
            }
            if(todosVC.todos.isEmpty){
              return centerText( 'No Todos Found.' ); 
            }

            return ListView.builder(
              itemCount: todosVC.todos.length,
              itemBuilder: (context, index) {
                final todo = todosVC.todos[index];
                return ListTile(
                  onTap: () => todosVC.toggleTodo( todo.id ),
                  leading: Checkbox(
                    value: todo.isCompleted, 
                    onChanged: (value) => todosVC.toggleTodo( todo.id ),
                    activeColor: Colors.blueAccent,
                  ),
                  title: Text(
                    todo.title ,
                    style: TextStyle(
                      decoration: todo.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () => todosVC.removeTodo(todo.id), 
                    icon: Icon(Icons.delete, color: const Color.fromARGB(255, 255, 17, 0))
                  ),
                  horizontalTitleGap: 0,
                );
              },
            );
          },
        ),

        floatingActionButton: Builder(
          builder: (context) {
            final todosVC = context.read<TodosViewController>();

            return FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddTodoDialog(todosVC: todosVC);
                  },
                );
              },
              child: Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }


  Center centerText(String text){
    return Center( child: Text(text, textAlign: TextAlign.center) );
  }
}