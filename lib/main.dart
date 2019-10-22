import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/activityList_provider.dart';
import 'package:task_app/widgets/activityList.dart';
import 'package:task_app/widgets/topBar.dart';
import 'package:task_app/widgets/dateList.dart';


void main() {
  return runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ActivityListProvider>(
      builder: (_) => ActivityListProvider(""),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
          fontFamily: 'Muli',
          backgroundColor: Colors.white
        ),
        home: MyHomePage(),
      )
    );
  }
}




class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final chosenDate = Provider.of<ActivityListProvider>(context);
    return SafeArea(
          child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: TopBar(
                    'Create Task'
                  ),
                  margin: EdgeInsets.only(top: 0),
                ),
                DateList(provider: chosenDate),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: 50, bottom: 10),
                      child: RichText(
                        text: TextSpan(text: "Choose activity: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: "Muli",
                            color: Colors.black
                          ),
                          children: [
                            TextSpan(text: chosenDate.getDate,
                              style: TextStyle(fontWeight: FontWeight.normal)
                            )
                          ]
                        )
                      )
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: ActivityList(),
                )
              ],
            )
          ),
      ),
    );
  }
}
