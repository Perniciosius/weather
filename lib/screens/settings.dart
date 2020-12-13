import 'package:weather/providers/unit_provider.dart';
import 'package:weather/utils/coverter.dart';
import 'package:flutter/material.dart';
import 'package:weather/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AppThemeMode _themeMode;
  Unit _temperatureUnit;

  @override
  Widget build(BuildContext context) {
    _temperatureUnit = Provider.of<UnitNotifier>(context).getUnit;
    _themeMode = Provider.of<ThemeModeNotifier>(context).getThemeMode();

    return Container(
      child: ListView(
        padding: EdgeInsets.only(left: 10, right: 10, top: 15),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Theme",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              color: Theme.of(context).accentColor.withOpacity(0.1),
            ),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: RadioListTile(
              value: AppThemeMode.SYSTEM,
              groupValue: _themeMode,
              onChanged: (value) {
                Provider.of<ThemeModeNotifier>(context, listen: false)
                    .setThemeMode(value);
              },
              title: Text('System'),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Theme.of(context).accentColor,
            ),
          ),
          Divider(
            height: 1.5,
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(0.1),
            ),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: RadioListTile(
              value: AppThemeMode.LIGHT,
              groupValue: _themeMode,
              onChanged: (value) {
                Provider.of<ThemeModeNotifier>(context, listen: false)
                    .setThemeMode(value);
              },
              title: Text('Light'),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Theme.of(context).accentColor,
            ),
          ),
          Divider(
            height: 1.5,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              color: Theme.of(context).accentColor.withOpacity(0.1),
            ),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: RadioListTile(
              value: AppThemeMode.DARK,
              groupValue: _themeMode,
              onChanged: (value) {
                Provider.of<ThemeModeNotifier>(context, listen: false)
                    .setThemeMode(value);
              },
              title: Text('Dark'),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Theme.of(context).accentColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Temperature Unit',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              color: Theme.of(context).accentColor.withOpacity(0.1),
            ),
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: RadioListTile(
              value: Unit.CELSIUS,
              groupValue: _temperatureUnit,
              onChanged: (value) {
                Provider.of<UnitNotifier>(context, listen: false)
                    .setUnit(value);
              },
              title: Text('Celsius'),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Theme.of(context).accentColor,
            ),
          ),
          Divider(
            height: 1.5,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              color: Theme.of(context).accentColor.withOpacity(0.1),
            ),
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: RadioListTile(
              value: Unit.FAHRENHEIT,
              groupValue: _temperatureUnit,
              onChanged: (value) {
                Provider.of<UnitNotifier>(context, listen: false)
                    .setUnit(value);
              },
              title: Text('Fahrenheit'),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
