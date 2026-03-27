class TodoModel {
  final int id;
  final String title;
  bool isCompleted;

  TodoModel({required this.id, required this.title, required this.isCompleted});

  factory TodoModel.fromJson( Map<String, dynamic> json ){
    return TodoModel(
      id: json['id'], 
      title: json['title'], 
      isCompleted: json['completed']
    );
  }
}