import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskname;
  final bool checkValue;
  final Function(bool?)? onChanged;
  final void Function(BuildContext)? deleteFunc;

  const TodoTile({
    super.key,
    required this.taskname,
    required this.checkValue,
    required this.onChanged,
    required this.deleteFunc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(11.0, 15.0, 11, 0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunc,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(30),
            ),

          ],
        ),
        child: Container(
          
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.yellow[400]
          ),
          child: Row(
            children: [
              Checkbox(value: checkValue, onChanged: onChanged),
              Text(
                taskname,
                style: TextStyle(
                  decoration: checkValue == true
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}