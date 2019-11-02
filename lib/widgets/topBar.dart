import 'package:flutter/material.dart';
import '../themify_icons.dart';

class TopBar extends StatelessWidget {
  final String text;
  final Color color;

  TopBar(this.text, {this.color});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 40),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Themify.control_stop, color: color,),
          Text(
            this.text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color
            )
          ),
          Icon(Themify.timer, size: 20, color: color,)
        ],
      ),
    );
  }
}