// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:task_app_1/constants/colors.dart';
import 'package:task_app_1/widgets/text_widget.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final String desc;
  final DateTime date;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const TaskTile({
    Key? key,
    required this.title,
    required this.desc,
    required this.date,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            showDialog(
                context: context,
                builder: (s) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TextWidget(
                            text: 'Do you want to edit or delete the Task',
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                                onPressed: onDelete,
                                child: const TextWidget(
                                    text: 'Delete',
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400)),
                            TextButton(
                                onPressed: onEdit,
                                child: const TextWidget(
                                    text: 'Edit',
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400))
                          ],
                        )
                      ],
                    ),
                  );
                });
          },
          trailing: TextWidget(
              text: DateFormat.yMMMEd().format(date),
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w400),
          leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: .3)),
              child: const Icon(
                Icons.tiktok,
                color: AppColors.lightBlue,
              )),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              TextWidget(
                text: desc,
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          title: TextWidget(
            text: title,
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Divider()
      ],
    );
  }
}
