

import 'package:flutter_sqlite/models/todo_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> todoDatabase() async{
  return openDatabase(join(await getDatabasesPath(), "flutter_todo.db"),
    onCreate: (db, version){
    return db.execute(
        "CREATE TABLE todo_tb(id INTEGER PRIMARY KEY AUTOINCREMENT, todo TEXT NOT NULL)",);
    },
      version:1
  );
}

// add todo
Future<TodoModel> addTodo(TodoModel todos) async{
  final db = await todoDatabase();
  db.insert("todo_tb", todos.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  return todos;
}

//update
Future<TodoModel> updateTodo(List id, TodoModel todos) async{
  final db = await todoDatabase();
  db.update("todo_tb", todos.toMap(), where: "id= ?",whereArgs: id);
  return todos;
}

// delete

Future<void> deleteTodo( List id) async{
  final db = await todoDatabase();
  db.delete("todo_tb", where: "id =?", whereArgs: id);
  // return id;
}

// Read Data
Future<List<Map>> readTodo() async{
  final db = await todoDatabase();
  return db.query("todo_tb");
}