import 'package:flutter/material.dart';

import 'package:task_app/themify_icons.dart';

class TaskTile extends StatefulWidget {
  final String heading;
  final String subHeading;
  final String sideText;

  TaskTile({
    this.heading = "Nothing", 
    this.subHeading = "No info", 
    this.sideText = "nothing"
  });

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool _active = false;

  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // SideText
        Transform.translate(
          offset: Offset(-20, 0),
          child: Transform.rotate(
            angle: 48.7,
            child: Container(
              width: 70,
              child: Text(
                _active ?  "Complete": widget.sideText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black38
                ),
              )
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(-14, 0),
                  child: Row(
            children: <Widget>[
          // CheckBox
          GestureDetector(
            child: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: _active ? Theme.of(context).primaryColor : Colors.transparent),
              child: _active ? Icon(Themify.check, size: 15, color: Colors.white)
              : Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColorLight,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(8)
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30)
                      ),
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              setState(() {
                _active = !_active;
              });
            },
          ),
          // Main Text body
          Container(
            margin: EdgeInsets.only(left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.heading,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Text(widget.subHeading)
              ],
            ),
          )
            ],
          ),
        ),

      ],
    );
  }
}
