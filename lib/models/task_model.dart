// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskModel {
  String taskName;
  DateTime date;
  String desc;
  int id;
  String userId;
  TaskModel({
    required this.taskName,
    required this.date,
    required this.desc,
    required this.id,
    required this.userId
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskName': taskName,
      'date': date.millisecondsSinceEpoch,
      'desc': desc,
      'id': id,
      'userId': userId,
    };
  }

  factory TaskModel.fromMap(dynamic map) {
    return TaskModel(
      taskName: map['taskName'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      desc: map['desc'] as String,
      id: map['id'] as int,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());




}
