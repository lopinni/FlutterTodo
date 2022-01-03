import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {

  const TaskTile(this.completed, this.task, this.taskID, {Key? key}) : super(key: key);
  final bool completed;
  final String task;
  final String taskID;

  @override
  State<TaskTile> createState() => _TaskTileState();

}

class _TaskTileState extends State<TaskTile> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              FirebaseFirestore.instance.collection("tasks")
                  .doc(widget.taskID).update({"done" : !widget.completed});
            },
            child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(24)
                ),
                child: widget.completed ?
                const Icon(Icons.check, color: Colors.green,) : Container()
            ),
          ),
          const SizedBox(width: 8,),
          Text(
            widget.task,
            style: TextStyle(
                color: widget.completed ?
                Colors.black : Colors.black.withOpacity(0.7),
                fontSize: 17,
                decoration: widget.completed ?
                TextDecoration.lineThrough : TextDecoration.none
            ),
          ),
          const Spacer(),
          GestureDetector(
              onTap: (){
                FirebaseFirestore
                    .instance.collection("tasks")
                    .doc(widget.taskID).delete();
              },
              child: Icon(
                  Icons.close, size: 15, color: Colors.black.withOpacity(0.7)
              )
          )
        ],
      ),
    );
  }

}