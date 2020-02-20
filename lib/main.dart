import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';
import 'model.dart';

void main() {
  runApp(MaterialApp(
    home: ToDo(),
    debugShowCheckedModeBanner: false,
  ));
}

class ToDo extends StatefulWidget {
  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  DatabaseHelper db;
  List<dynamic> taskList;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  final GlobalKey<DrawerControllerState> _drawerkey = new GlobalKey();
  Future<int> saveTask(icon, name, description, dateTime) async {
    Task task = Task(icon, name, description, dateTime, 0);
    return await db.saveTask(task);
  }

  Future<dynamic> getAllTask() async {
    return await db.getAllTask();
  }

  Future<DatabaseHelper> getDatabaseHelper() async {

    db = DatabaseHelper();
    taskList = await getAllTask();

  }
  Widget drawerState(){
    return ListView(
      children: <Widget>[
        Text('New Task',style: TextStyle(color: Colors.grey),),
        Text('Name',style: TextStyle(color: Colors.grey),),
        TextField(controller: nameController,),
        Text('Date',style: TextStyle(color: Colors.grey),),
        TextField(controller: dateController,),
        Text('Time',style: TextStyle(color: Colors.grey),),
        TextField(controller: timeController,),
        Text('Project type',style: TextStyle(color: Colors.grey),),
        TextField(controller: typeController,),
        Text('Descripton',style: TextStyle(color: Colors.grey),),
        TextField(controller: descriptionController,),
      ],
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatabaseHelper();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();


    return Scaffold(
      key: _scaffoldkey,
      endDrawer: Drawer(child: ListView(
        children: <Widget>[
          Text('New Task',style: TextStyle(color: Colors.grey),),
          Text('Name',style: TextStyle(color: Colors.grey),),
          Flexible(child: TextField(controller: nameController,)),
          Text('Date',style: TextStyle(color: Colors.grey),),
          Flexible(child: TextField(controller: dateController,)),
          Text('Time',style: TextStyle(color: Colors.grey),),
          Flexible(child: TextField(controller: timeController,)),
          Text('Project type',style: TextStyle(color: Colors.grey),),
          Flexible(child: TextField(controller: typeController,)),
          Text('Descripton',style: TextStyle(color: Colors.grey),),
          Flexible(child: TextField(controller: descriptionController,)),
        ],
      ),),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () => print('calender'),
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                InkWell(
                  onTap: () {
                      _scaffoldkey.currentState.openEndDrawer(

                      );
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Tasks',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            for (int i = 0; i < taskList.length; i++)
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          colors: [Colors.pinkAccent, Colors.purple],
                          end: Alignment.centerRight,
                          begin: Alignment.centerLeft)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        height: 60,
                        width: 5,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.pinkAccent, Colors.purple],
                                end: Alignment.bottomCenter,
                                begin: Alignment.topCenter)),
                      ),
                      Radio(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            '${taskList[i]['name']}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text('${taskList[i]['description']}',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Text(
                        '${taskList[i]['dateTime']}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.add_alert,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Today',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${taskList.length}',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  'See All',
                  style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
