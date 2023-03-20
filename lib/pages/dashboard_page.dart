import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.menu,
                                  color: Colors.white60,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const TextWidget(
                                    text: 'Your\nThings',
                                    color: Colors.white,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w300),
                                const SizedBox(
                                  height: 35,
                                ),
                                TextWidget(
                                    text: DateFormat.MMMEd()
                                        .format(DateTime.now()),
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w100),
                              ],
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Container(
                            height: 4,
                            width: MediaQuery.of(context).size.width * .56,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(colors: [
                              AppColors.violetGradient,
                              AppColors.blueGradient,
                              AppColors.lightblueGradient
                            ])),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Card(
                        margin: EdgeInsets.zero,
                        color: Colors.transparent,
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * .1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    label('Personal', '24'),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    label('Business', '15'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircularPercentIndicator(
                                      radius: 7.0,
                                      lineWidth: 1.5,
                                      percent: .65,
                                      backgroundColor: Colors.transparent,
                                      linearGradient: const LinearGradient(
                                          colors: [
                                            AppColors.violetGradient,
                                            Colors.blue,
                                            AppColors.lightblueGradient
                                          ]),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: SizedBox(
                                        height: 20,
                                        child: TextWidget(
                                            text: '65% done',
                                            color: Colors.white54,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w200),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
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
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<List<TaskModel>>(
                      stream: database.getTask(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          return Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,

                                itemBuilder: (c,i){
                                return TaskTile(
                                        isProfileRequired: i%2==0?true:false,
                                          onDelete: () {
                                            database.deleteTask(snapshot.data![i].id);
                                            Navigator.pop(context);
                                          },
                                          onEdit: () {
                                            Navigator.pop(context);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: ((a) =>
                                                        AddTaskScreen(
                                                          isEdit: true,
                                                          database: database,
                                                          uid: uid,
                                                          desc:snapshot.data![i].desc,
                                                          id: snapshot.data![i].id,
                                                          startDate: snapshot.data![i].date,
                                                          task: snapshot.data![i].taskName,
                                                        ))));
                                          },
                                          title: snapshot.data![i].taskName,
                                          desc: snapshot.data![i].desc,
                                          date: snapshot.data![i].date);
                              }),
                             
                              Row(
                                children: [
                                  const TextWidget(
                                      text: 'COMPLETED',
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                     const  SizedBox(width: 6,),
                                  Container(
                                
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: TextWidget(
                                            text: snapshot.data!.length.toString(),
                                            color: Colors.white,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          );
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

  Widget label(String label, String value) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextWidget(
                text: value,
                color: Colors.white70,
                fontSize: 25,
                fontWeight: FontWeight.w400),
            TextWidget(
                text: label,
                color: Colors.white38,
                fontSize: 12,
                fontWeight: FontWeight.w200)
          ],
        )
      ],
    );
  }
}
