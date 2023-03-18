import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_app_1/constants/colors.dart';
import 'package:task_app_1/models/task_model.dart';
import 'package:task_app_1/pages/add_task_screen.dart';
import 'package:task_app_1/services/auth_service.dart';
import 'package:task_app_1/services/database.dart';
import 'package:task_app_1/widgets/list_tile.dart';
import 'package:task_app_1/widgets/text_widget.dart';

class Dashboard extends StatelessWidget {
  final String uid;
  const Dashboard({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("images/background.jpeg"),
                fit: BoxFit.fill,
              )),
              height: 200,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                   const   Icon(
                        Icons.menu,
                        color: Colors.white60,
                      ),
                    const  SizedBox(height: 20,),
                    const  TextWidget(
                          text: 'Your\nThings',
                          color: Colors.grey,
                          fontSize: 25,
                          fontWeight: FontWeight.w100),
                        const   SizedBox(height: 20,),
                      TextWidget(
                          text: DateFormat.yMMMEd().format(DateTime.now()),
                          color: Colors.grey,
                          fontSize: 25,
                          fontWeight: FontWeight.w100),
                           
                      
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const TextWidget(
                      text: 'INBOX',
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                  StreamBuilder<List<TaskModel>>(
                      stream: database.getTask(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          return Column(
                              children: snapshot.data!
                                  .map((e) => TaskTile(
                                      onDelete: () {
                                        database.deleteTask(e.id);
                                        Navigator.pop(context);
                                      },
                                      onEdit: () {
                                        Navigator.pop(context);
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: ((a) => AddTaskScreen(
                                                      isEdit: true,
                                                      database: database,
                                                      uid: uid,
                                                      desc: e.desc,
                                                      id: e.id,
                                                      startDate: e.date,
                                                      task: e.taskName,
                                                    ))));
                                      },
                                      title: e.taskName,
                                      desc: e.desc,
                                      date: e.date))
                                  .toList());
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(30.0),
                            child: TextWidget(
                                text: 'Loading',
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          );
                        }
                      }),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.lightBlue,
          child: const Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((a) => AddTaskScreen(
                      isEdit: false,
                      database: database,
                      uid: uid,
                    ))));
          }),
    );
  }
}
