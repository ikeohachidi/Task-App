import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/activityList_provider.dart';

import 'package:task_app/widgets/taskTile.dart';
import "package:task_app/widgets/topBar.dart";

class TaskScreenArguments {
  final String category;

  TaskScreenArguments(this.category);
}

class TaskScreen extends StatefulWidget {
  static String routeName = "/task";

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<TaskScreen> {
  Widget build(BuildContext context) {
    TaskScreenArguments args = ModalRoute.of(context).settings.arguments;
    ActivityListProvider provider = Provider.of<ActivityListProvider>(context);

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TopBar(
                  "${provider.chosenDate.date} ${provider.chosenDate.month}",
                  color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(args.category,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      SizedBox(height: 10),
                      Text("Nothing yet",
                          style: TextStyle(
                            color: Colors.white,
                          ))
                    ],
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text("Add Task",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20))),
                ],
              ),
            ),
            Container(
                height: (() {
                  if(usersTasks.length < 5) {
                    return MediaQuery.of(context).size.height;
                  }
                })(),
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.only(top: 40, left: 40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(45))),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(provider.chosenDate.date,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white)),
                                SizedBox(height: 10),
                                Text(provider.chosenDate.day,
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(children: (() {
                      List<Widget> tasksRows = [];
                      for (var i = 0; i < usersTasks.length; i++) {
                        tasksRows.add(Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: TaskTile(
                              heading: usersTasks[i]["taskName"],
                              subHeading: usersTasks[i]["deadLine"],
                              sideText: usersTasks[i]["timeDifference"],
                            )));
                      }
                      return tasksRows;
                    })())
                  ],
                )),
          ],
        )));
  }
}

// todo: make String parameter a generic which cna take either String or bool
List<Map<String, String>> usersTasks = [
  {
    "taskName": "Buy a pack of coffee",
    "deadLine": "10: 30 - 11: 00",
    "timeDifference": "30 mins",
    "status": "false"
  },
];
