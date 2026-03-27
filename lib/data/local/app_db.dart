import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_db.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  BoolColumn get isCompleted => boolean().withDefault( Constant(false))() ;
}


@DriftDatabase(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Create
  Future<int> insertTodo(TodosCompanion todo) => into(todos).insert(todo);

  // Read
  Stream<List<Todo>> watchTodos() {
    return select(todos).watch();
  }
  
  // Delete
  Future<void> deleteTodo(int id) =>
      ( delete(todos)..where( (t) => t.id.equals(id))).go();

  // Update
  Future<void> toggleTodo( int id, bool value ) =>
      ( update(todos)..where( (t) => t.id.equals(id) ) )
            .write(  TodosCompanion( isCompleted: Value(value) )  ) ;
      
}


LazyDatabase _openConnection() {
  return LazyDatabase( () async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File( p.join(dir.path, 'todos.db') );
    return NativeDatabase(file);
  });
}