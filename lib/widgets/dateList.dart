import "package:flutter/material.dart";
import "package:task_app/widgets/dateButton.dart";

class DateList extends StatelessWidget {
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      // todo fix this i want the scroll button to have absolute dominance
      Expanded(
        child: SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: Dates().widgets
          ),
        ),
      ),
    ]);
  }
}

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

  String dayAndWeekDay;

  List<Widget> widgets = [];
  var dateSet = new Set();

  Map<String, List<Map<String, String>>> monthsMap = new Map();

  Dates() {
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
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: DateButton(date: f["date"], day: f["day"])
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
