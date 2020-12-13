import 'package:weather/utils/coverter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnitNotifier with ChangeNotifier {
  Unit _unit;

  UnitNotifier() {
    initUnit();
  }

  Future<void> initUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int unitIndex = prefs.getInt('unit') ?? 0;
    _unit = Unit.values.elementAt(unitIndex);
  }

  Unit get getUnit => _unit;

  void setUnit(Unit unit) async {
    _unit = unit;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('unit', unit.index);
    notifyListeners();
  }
}
