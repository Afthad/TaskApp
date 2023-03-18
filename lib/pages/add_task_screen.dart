import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app_1/constants/colors.dart';
import 'package:task_app_1/models/task_model.dart';
import 'package:task_app_1/services/auth_service.dart';
import 'package:task_app_1/services/database.dart';
import 'package:task_app_1/widgets/date_picker.dart';
import 'package:task_app_1/widgets/text_widget.dart';

class AddTaskScreen extends StatefulWidget {
  final Database database;
  final String uid;
  final bool isEdit;
  final DateTime? startDate;
 final String? task;
 final int? id;

 final String? desc;

  const AddTaskScreen({super.key, required this.database, required this.uid, this.desc,required this.isEdit, this.task, this.startDate,this.id});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if(widget.isEdit){
    _startDate=widget.startDate!;
    }
    super.initState();
  }

  DateTime _startDate = DateTime.now();
  String? task;

  String? desc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundViolet,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.backgroundViolet,
          centerTitle: true,
          title: const TextWidget(
              text: 'Add New Thing',
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: .3)),
                      child: const Icon(
                        Icons.tiktok,
                        color: Colors.white,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: widget.task,
                  style: const TextStyle(color: Colors.white38),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Task Name';
                    }
                    if (value.length > 100) {
                      return 'Task Name should be maximum of 100 chars';
                    }
                  },
                  onChanged: (s) {
                    task = s;
                  },
                  onSaved: (s){
                    task=s;
                  },
                  decoration: inputDecoration(hintText: 'Task name'),
                ),
                TextFormField(
                    initialValue: widget.desc,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Task Desc';
                    }

                    if (value.length > 1000) {
                      return 'Task Name should be maximum of 1000 chars';
                    }
                  },
                  onChanged: (s) {
                    desc = s;
                  },
                  onSaved: (s){
                    desc=s;
                  },
                  style: const TextStyle(color: Colors.white38),
                  decoration: inputDecoration(hintText: 'Description'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.centerLeft, child: _buildStartDate()),
                const SizedBox(
                  height: 30,
                ),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    height: 44,
                    minWidth: MediaQuery.of(context).size.width - 100,
                    color: AppColors.lightBlue,
                    child: const TextWidget(
                      text: 'Add your thing',
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    onPressed: () {
                      submit();
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ));
  }

  submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if(!widget.isEdit){
      await widget.database.setTask(TaskModel(
        taskName: task!,
        date: _startDate,
        desc: desc!,
        id: _startDate.millisecondsSinceEpoch,
        userId: widget.uid,
      ));
      }else{
        await widget.database.updateTask(TaskModel(
        taskName: task!,
        date: _startDate,
        desc: desc!,
        id: widget.id!,
        userId: widget.uid,
      ));
      }
    }
  }

  Widget _buildStartDate() {
    return SizedBox(
      height: 30,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: DateTimePicker(
          labelText: 'Start Date',
          selectedDate: _startDate,
          onSelectedDate: (date) => setState(() => _startDate = date),
        ),
      ),
    );
  }

  InputDecoration inputDecoration({String? hintText}) {
    return InputDecoration(
      border: InputBorder.none,
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
      contentPadding: const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
      focusedBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0)),
      enabledBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
