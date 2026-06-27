import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/data/database.dart';
import 'package:todo/util/in_button.dart';
import 'package:todo/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _mybox = Hive.box('mybox');

  


  TextEditingController mycontroller = TextEditingController();

  String greetuser() {
    return (mycontroller.text);
  }

  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    
    if(_mybox.get("ITEMVIEW")==null){
      db.createInitialData();
    }else{
      db.loadData();
    }

    super.initState();
    db.updateDatabase();
  }

  void changes(bool? value, int index) {
    setState(() {
      db.itemview[index][1] = !db.itemview[index][1];
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('ToDo')), elevation: 3, backgroundColor: Colors.yellow,),
      body: ListView.builder(
        itemCount: db.itemview.length,
        itemBuilder: (context, index) {
          return TodoTile(
            deleteFunc: (context) {
              setState(() {
                db.itemview.removeAt(index);
                db.updateDatabase();
              });
            },
            taskname: db.itemview[index][0],
            checkValue: db.itemview[index][1],
            onChanged: (value) { setState(() {
              db.itemview[index][1] = !db.itemview[index][1];
            });
            db.updateDatabase();
        }
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SizedBox(
                  height: 140,
                  width: 40,
                  child: Column(
                    children: [
                      TextField(
                        controller: mycontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Whats the task',
                        ),
                        autofocus: true,
                      ),

                      SizedBox(height: 30,),

                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                          InButton(buttname: 'Save', onPressed: () {
                            setState(() {
                              db.itemview.add([mycontroller.text, false]);
                              mycontroller.clear();
                              db.updateDatabase();
                            }
                            );

                            Navigator.of(context).pop();
                          }),
                          SizedBox(width: 10,),
                          InButton(buttname: 'Cancel', onPressed: () {Navigator.of(context).pop();})
                    ],),
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.yellow[400],
        child: Icon(Icons.add),
      ),
    );
  }
}

