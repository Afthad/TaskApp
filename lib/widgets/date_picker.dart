// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:task_app_1/widgets/text_widget.dart';



class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    
    Key? key,
    required this.labelText,
    required this.selectedDate,
    required this.onSelectedDate,
  }) : super(key: key);

  final String  labelText;
  final DateTime selectedDate;

  final ValueChanged<DateTime> onSelectedDate;
 

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      onSelectedDate(pickedDate);
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left:5.0),
            child: TextWidget(text:DateFormat.yMEd().format(selectedDate),color: Colors.white38,fontSize: 12,fontWeight: FontWeight.w400),
          ),
         const Divider(color: Colors.white,endIndent:8,)
        ],
      ),
      onTap: () => _selectDate(context),
    );
  }
}
