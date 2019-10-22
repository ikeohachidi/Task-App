import 'package:flutter/material.dart';
import 'package:task_app/providers/activityList_provider.dart';

class DateButton extends StatefulWidget {
  final String date;
  final String day;
  final String month;

  final ActivityListProvider provider;

  DateButton({this.month, this.date, this.day, this.provider});

  @override
  _DateButtonState createState() => _DateButtonState();
}

class _DateButtonState extends State<DateButton> {
  bool active = false;

  Widget build(BuildContext context) {
    if (widget.provider.getDate == "${widget.month.substring(0, 3)} ${widget.date} ${widget.day}") {
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
          color: active == true ? Colors.deepPurple : Color.fromRGBO(230, 230, 230, 1),
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
        if (widget.provider.getDate == "${widget.month.substring(0, 3)} ${widget.date} ${widget.day}") {
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
