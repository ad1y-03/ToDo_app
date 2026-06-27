import 'package:hive_flutter/adapters.dart';

class ToDoDataBase {

  List itemview = [];

  final _mybox = Hive.box('mybox');

  void createInitialData(){
    itemview = [["Make Some", false],["Run", false]];
  }

  void loadData(){
    itemview = _mybox.get("ITEMVIEW");
  }

  void updateDatabase(){
    _mybox.put("ITEMVIEW", itemview);
  }
}