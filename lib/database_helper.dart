import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'model.dart';
class DatabaseHelper{
  String tableTask= "task";
  String taskId= "id";
  String taskIcon= "icon";
  String taskName= "name";
  String taskDescription= "description";
  String taskDate= "dateTime";
  String taskDone= "done";

  static final DatabaseHelper _instance = DatabaseHelper.insternal();
  factory DatabaseHelper(){
    return _instance;
  }
  DatabaseHelper.insternal();
  static Database _db;

  Future<Database> get db async{
    if(_db!=null){
      return _db;
    }
    _db= await initDb();
    return _db;
  }
  initDb() async{
    Directory directory= await getApplicationDocumentsDirectory();
    String path= join(directory.path,"main.db");
    var ourDb= await openDatabase(path,version: 1,onCreate: onCreate);
    return ourDb;
  }
  void onCreate(Database db,int version)async{
    await db.execute("CREATE TABLE $tableTask($taskId INTEGER PRIMARY KEY, $taskIcon TEXT, $taskName TEXT, $taskDescription TEXT, $taskDate TEXT, $taskDone INTEGER)");
  }
  Future<int> saveTask(Task task)async{
    var dbClient= await db;
    int result = await dbClient.insert("$tableTask", task.toMap());
    return result;
  }
  Future<List> getAllTask()async{
    var dbClient= await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableTask");
    return result.toList();
  }
  Future<Task> getTask(int id)async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableTask WHERE $taskId=$id");
    if(result.length==0){
      return null;
    }
    return Task.fromMap(result.first);
  }
  Future<int> updateTask(Task task) async{
    var dbClient= await db;
    Task newTask = task;
    print(" * * * ${task.done}");
    Map map = task.toMap();
    print("Done status ${map['done']}");

    return await dbClient.update(tableTask, task.toMap(), where: '$taskId = ?', whereArgs: ["${map['id']}"]);
  }
  Future<int> deleteTask(int id)async{
    var dbClient = await db;
    return await dbClient.delete("$tableTask",where: "$taskId=?",whereArgs: [id]);
  }
}