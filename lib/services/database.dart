// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:task_app_1/models/task_model.dart';
import 'package:task_app_1/services/firebase_service.dart';

import 'api_path.dart';

abstract class Database {
  Future<void> setTask(TaskModel taskModel);
  Future<void> deleteTask(int id);
  Future<void> updateTask(TaskModel model);
    Stream<List<TaskModel>> getTask();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  String uid;
  FirestoreDatabase({
    required this.uid,
  });
  final _service = FirestoreService.instance;

  @override
  Future<void> setTask(TaskModel taskModel) async => await _service.setData(
        path: APIPath.tasks(taskModel.id),
        data: taskModel.toMap(),
      );

  @override
  Future<void> deleteTask(id) async => await _service.deleteData(
        path: APIPath.tasks(id),
      );

 @override
  Stream<List<TaskModel>> getTask() =>
      _service.collectionStream(
        path: APIPath.getTask(),
        builder: (data) => TaskModel.fromMap(data),
        queryBuilder: (query) => query.where('userId',isEqualTo: uid),
      );
  @override
  Future<void> updateTask(TaskModel model) async => await _service.update(
        path: APIPath.tasks(
          model.id,
        ),
        data: model.toMap(),
      );
}
