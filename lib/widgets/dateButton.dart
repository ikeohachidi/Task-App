import 'package:flutter/material.dart';

class DateButton extends StatefulWidget {
  final String date;
  final String day;

  DateButton({this.date, this.day});

  @override
  _DateButtonState createState() => _DateButtonState();
}

class _DateButtonState extends State<DateButton> {
  bool active = false;

  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 60,
        decoration: BoxDecoration(
          color: active == true ? Colors.deepPurple : Color.fromRGBO(230, 230, 230, 1),
          borderRadius: BorderRadius.all(Radius.circular(17))
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
        setState(() { 
          active = !active;
        });
      },
    );
  }
}
