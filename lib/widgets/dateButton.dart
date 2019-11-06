import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/activityList_provider.dart';

class DateButton extends StatefulWidget {
  final String date;
  final String day;
  final String month;

  // final ActivityListProvider provider;

  DateButton({this.month, this.date, this.day});

  @override
  _DateButtonState createState() => _DateButtonState();
}

class _DateButtonState extends State<DateButton> {
  bool active = false;

  Widget build(BuildContext context) {
    final ActivityListProvider provider = Provider.of<ActivityListProvider>(context);

    String date = provider.chosenDate.date;
    String day = provider.chosenDate.day;
    String month = provider.chosenDate.month;

    String fullDate = "$month $date $day";
    
    if (fullDate == "${widget.month.substring(0, 3)} ${widget.date} ${widget.day}") {
      setState(() {
        active = true; 
      });
    } else {
      active = false;
    }
    return GestureDetector(
      child: Container(
        width: 60,
        decoration: BoxDecoration(
          color: active == true ? Theme.of(context).primaryColor : Color.fromRGBO(230, 230, 230, 0.5),
          borderRadius: BorderRadius.all(Radius.circular(17)),
          boxShadow: active == true ? [
            BoxShadow(
              color: Color.fromRGBO(200, 200, 200, 1),
              offset: Offset(0, 3),
              blurRadius: 5,
              spreadRadius: 1.5
            )
          ] : []
        ),
        padding: EdgeInsets.all(10),
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.date,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: active == true ? Colors.white : Colors.black
              ),
            ),
            Text(
              widget.day,
              style: TextStyle(
                color: active == true ? Colors.white : Colors.black
              )
            )            
          ],
        ),
      ),
      onTap: () {
        if (fullDate == "${widget.month.substring(0, 3)} ${widget.date} ${widget.day}") {
          setState(() {
           active = true; 
          });
        } else {
          active = false;
        }
      },
    );
  }
}
