import 'package:flutter/material.dart';
import 'package:task_app/themify_icons.dart';

const content = {
  'Work': {'icon': Themify.rocket, 'subheading': '0'},
  'Food': {'icon': Themify.gift, 'subheading': '0'},
  'Idea': {'icon': Themify.light_bulb, 'subheading': '0'},
  'Sport': {'icon': Themify.basketball, 'subheading': '0'}
};

List<Widget> activities() {
  List<Widget> list = [];

  content.keys.forEach((x) {
    list.add(
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          padding: EdgeInsets.only(top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: Color.fromRGBO(230, 230, 230, 1),
            borderRadius: BorderRadius.all(Radius.circular(6))
          ),
          child: ListTile(
            leading: Icon(content[x]['icon'], color: Colors.deepPurple,),
            title: Text(
              '$x',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            trailing: Icon(
              Themify.angle_right, 
              color: Colors.deepPurple,
              size: 16
            ),
          ),
        )
    );  
  });

  return list;
}

class ActivityList extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: activities()
    );
  }
}