import 'package:flutter/material.dart';

class DateActivity {
  final String day;
  final String date;
  final String month;

  DateActivity({this.day, this.date, this.month});
}

// Gets the date needed by the user
class ActivityListProvider with ChangeNotifier {

  DateActivity chosenDate;

  ActivityListProvider() {
    this.chosenDate = DateActivity(day: "", date: "", month: "");
  }

  get getDate => this.chosenDate;

  get builtDate => "${this.chosenDate.month} ${this.chosenDate.date} ${this.chosenDate.day}";

  set setChosenDate(DateActivity date) {
    this.chosenDate = date;
    notifyListeners();
  }

}