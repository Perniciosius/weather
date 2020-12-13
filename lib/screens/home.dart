import 'package:weather/screens/settings.dart';
import 'package:weather/widgets/current_weather.dart';
import 'package:weather/widgets/graph.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int _currentIndex = 0;
  List<String> _title = ['Weather', 'Weather', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title[_currentIndex]),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 8,
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: 'Weather',
              icon: Icon(Icons.cloud),
            ),
            BottomNavigationBarItem(
              label: 'Graph',
              icon: Icon(Icons.graphic_eq),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(Icons.settings),
            ),
          ],
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: IndexedStack(
            key: ValueKey<int>(_currentIndex),
            index: _currentIndex,
            children: [
              CurrentWeather(),
              Graph(),
              SettingsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
