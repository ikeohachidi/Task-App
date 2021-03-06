import 'package:flutter/material.dart';
import 'package:task_app/screen/taskScreen.dart';
import 'package:task_app/themify_icons.dart';

const content = {
  'Work': {'icon': Themify.rocket, 'subheading': '0'},
  'Food': {'icon': Themify.gift, 'subheading': '0'},
  'Idea': {'icon': Themify.light_bulb, 'subheading': '0'},
  'Sport': {'icon': Themify.basketball, 'subheading': '0'}
};

List<Widget> activities(BuildContext context) {
  List<Widget> list = [];

  content.keys.forEach((x) {
    list.add(
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          padding: EdgeInsets.only(top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: Color.fromRGBO(230, 230, 230, 0.5),
            borderRadius: BorderRadius.all(Radius.circular(6))
          ),
          child: ListTile(
            leading: Icon(content[x]['icon'], color: Theme.of(context).primaryColor,),
            title: Text(
              '$x',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            trailing: Icon(
              Themify.angle_right, 
              color: Theme.of(context).primaryColor,
              size: 16
            ),
            onTap: () {
              Navigator.pushNamed(context, 
                TaskScreen.routeName,
                arguments: TaskScreenArguments('$x')
              );
            },
          ),
        )
    );  
  });

  return list;
}

class ActivityList extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: activities(context)
    );
  }
}