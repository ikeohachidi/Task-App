import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/activityList_provider.dart';

import 'package:task_app/widgets/taskTile.dart';
import "package:task_app/widgets/topBar.dart";

import "package:task_app/themify_icons.dart";

class TaskScreenArguments {
  final String category;

  TaskScreenArguments(this.category);
}

class TaskScreen extends StatefulWidget {
  static String routeName = "/task";

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<TaskScreen> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  bool taskScreenVisiblity = false;

  @override
  initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this
    );
    animation = Tween<double>(begin: 2, end: 0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut
      )
    )..addListener(() {
        setState(() {
          if (animation.value == 2) {
            taskScreenVisiblity = false;
          } else {
            taskScreenVisiblity = true;
          }
        });
      });
  }

  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {

    InputDecoration textFieldLook(String text) {
      return InputDecoration(
        hintText: text,
        fillColor: Color.fromRGBO(246, 246, 246, 1),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide(
              width: 2,
              color: Theme.of(context).primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide(
              width: 1,
              color: Colors.transparent,
              style: BorderStyle.none),
        ),
      );
    }

    TaskScreenArguments args = ModalRoute.of(context).settings.arguments;
    ActivityListProvider provider = Provider.of<ActivityListProvider>(context);

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
            child: Stack(
          children: <Widget>[
            Column(
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
                      // **************
                      // **************
                      // add task button
                      GestureDetector(
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 30),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text("Add Task",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                          ),
                        onTap: () => animationController.forward()
                      ),
                    ],
                  ),
                ),
                Container(
                    height: (() {
                      if (usersTasks.length < 5) {
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
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
            ),
            // Add task window
            Visibility(
              visible: taskScreenVisiblity,
              child: Transform.translate(
                offset: Offset(0, MediaQuery.of(context).size.height/2 * animation.value),
                child: SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            child: Icon(Themify.close),
                            onTap: () => animationController.reverse()
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: TextFormField(
                            decoration: textFieldLook("Task Title.."),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 8,
                            decoration: textFieldLook("Details of the task..."),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Row(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text("From"),
                              ),
                              SizedBox(
                                width: 70,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: textFieldLook("Hour"),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(":"),
                              ),
                              SizedBox(
                                width: 70,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: textFieldLook("Min"),
                                ),
                              ),
                            ])),
                        Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 24.0),
                                child: Text("To"),
                              ),
                              SizedBox(
                                width: 70,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: textFieldLook("Hour"),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(":"),
                              ),
                              SizedBox(
                                width: 70,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: textFieldLook("Min"),
                                ),
                              ),
                            ]))
                      ],
                    ),
                  ),
                ),
              ),
            )
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
  }
];
