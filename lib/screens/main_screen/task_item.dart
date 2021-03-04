
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show utf8;

import 'package:trello_app/models/task.dart';
import 'package:trello_app/utils/color.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const  TaskItem({Key key, this.task}): super(key: key);

  @override
  Widget build(BuildContext context) {

    var encode =  utf8.decode(task.text.runes.toList());

    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      color: AppColor.black3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ID: ${task.id.toString()}",
            style: TextStyle(color: AppColor.wight),),
          Text(encode.toString(), style: TextStyle(color: AppColor.wight),)
        ],
      ),
    );
  }
}
