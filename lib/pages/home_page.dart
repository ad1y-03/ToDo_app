import 'package:flutter/material.dart';
import 'package:todo/util/in_button.dart';
import 'package:todo/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  TextEditingController mycontroller = TextEditingController();

  String greetuser() {
    return (mycontroller.text);
  }

  List itemview = [
    ['Hello', false]
  ];

  void changes(bool? value, int index) {
    setState(() {
      itemview[index][1] = !itemview[index][1];
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('ToDo')), elevation: 3, backgroundColor: Colors.yellow,),
      body: ListView.builder(
        itemCount: itemview.length,
        itemBuilder: (context, index) {
          return TodoTile(
            deleteFunc: (context) {
              setState(() {
                itemview.removeAt(index);
              });
            },
            taskname: itemview[index][0],
            checkValue: itemview[index][1],
            onChanged: (value) => setState(() {
              itemview[index][1] = !itemview[index][1];
            },),
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
                              itemview.add([mycontroller.text, false]);
                              mycontroller.clear();
                            });

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

