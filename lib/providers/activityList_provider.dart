import 'package:flutter/material.dart';


// Gets the date needed by the user
class ActivityListProvider with ChangeNotifier {
  String _chosenDate;

  ActivityListProvider(this._chosenDate);

  get getDate => this._chosenDate;

  set setChosenDate(String chosenDate) {
    this._chosenDate = chosenDate;
    notifyListeners();
  }

}