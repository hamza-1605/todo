import 'package:flutter/material.dart';
import 'package:todo/viewController/todos_view_controller.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({ super.key,  required this.todosVC });
  final TodosViewController todosVC;

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text("Add a Todo"),
        content: TextField(
          controller: titleController,
          decoration: InputDecoration(
            hintText: "Enter the title",
          ),
          textCapitalization: TextCapitalization.sentences,
          onChanged: (value) => setState(() => {},),
        ),
      
        actions: [
          ElevatedButton(
            onPressed: ()=> Navigator.pop(context), 
            child: Text("Cancel") 
          ),
          FilledButton(
            onPressed: titleController.text.trim().isEmpty
              ? null
              : (){
                  widget.todosVC.createTodo( titleController.text.trim() );
                  Navigator.pop(context);
                }, 
              child: Text("Add") 
            ),
        ],
      ),
    );
  }
}