import "package:flutter/material.dart";
import 'package:task_app/providers/activityList_provider.dart';
import "package:task_app/widgets/dateButton.dart";
import 'package:flutter/gestures.dart';

class DateList extends StatelessWidget {
  final ActivityListProvider provider;

  DateList({this.provider});

  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      // todo fix this i want the scroll button to have absolute dominance
      Expanded(
        child: SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: Dates(provider: provider).widgets
          ),
        ),
      ),
    ]);
  }
}


// Dates class builds the DateButton widget with proper dates 
// It receives a provider so the app can be notified when one of the button on the
// widget is clicked and can process the date also
class Dates {
  DateTime date = new DateTime.now();

  static List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  
  static List<String> weekDays = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun"
  ];

  List<Widget> widgets = [];
  var dateSet = new Set();

  Map<String, List<Map<String, String>>> monthsMap = new Map();

  final ActivityListProvider provider;

  Dates({this.provider}) {
    for (var i = 0; i < 60; ++i) {
      DateTime newDate = date.add(Duration(days: i));

      var monthAndYear = months[newDate.month - 1] + " " + newDate.year.toString();

      if (!dateSet.contains(monthAndYear)) {
        dateSet.add(monthAndYear);
        monthsMap[monthAndYear] = [];
        monthsMap[monthAndYear].add(
          {
            "date": newDate.day.toString(),
            "day": weekDays[newDate.weekday - 1]
          }
        );
      } else {
        monthsMap[monthAndYear].add(
          {
            "date": newDate.day.toString(),
            "day": weekDays[newDate.weekday - 1]
          }
        );
      }
    }

    monthsMap.forEach((month, dateAndDay) {
      widgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      month,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  )
                ]
              ),
            Row(
              children: (() {
                List<Widget> dateButtonList = [];
                dateAndDay.forEach((f) {
                  dateButtonList.add(
                    // Without RawGestureDetector the child DateButton child widget wins the
                    // battle for the onTap event and this tap won't work
                      RawGestureDetector(
                        gestures: <Type, GestureRecognizerFactory>{
                          AllowMultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<AllowMultipleGestureRecognizer>(
                            () => AllowMultipleGestureRecognizer(),
                            (AllowMultipleGestureRecognizer instance) {
                              instance.onTap = () => {
                                provider.setChosenDate = "${month.substring(0, 3)} ${f["date"]} ${f["day"]}"
                              };
                            }
                          ),
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          margin: EdgeInsets.only(right: 15),
                          child: DateButton(month: month, date: f["date"], day: f["day"], provider: provider)
                        ),
                      )
                  );
                });
                return dateButtonList;
              })()
            )
          ],
        )
      );
    });

  }
}

class AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}