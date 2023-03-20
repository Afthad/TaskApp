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
  final bool isProfileRequired;
  const TaskTile({
    Key? key,
    required this.title,
    required this.desc,
    required this.date,
    required this.isProfileRequired,
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
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(
                  text: DateFormat.j().format(date),
                  color: Colors.grey,
                  fontSize: 8,
                  fontWeight: FontWeight.w600),
                  isProfileRequired?
              Row(
                mainAxisSize: MainAxisSize.min,
                children:const [
                  CircleAvatar(
                    backgroundImage: AssetImage('images/profile_1.jpg',),
                    radius: 8,),
                    CircleAvatar(
                    backgroundImage: AssetImage('images/profile_1.jpg',),
                    radius: 8,),
                ],
              ):const SizedBox()
            ],
          ),
          leading: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: .3)),
              child: const Icon(
                Icons.music_note_outlined,
                color: AppColors.lightBlue,
              )),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           
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
