import 'package:weather/api/weather_api.dart';
import 'package:weather/providers/unit_provider.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/screens/home.dart';
import 'package:weather/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeModeNotifier()),
      ChangeNotifierProvider(
        create: (_) => WeatherNotifier(weatherApi: WeatherApi()),
        lazy: false,
      ),
      ChangeNotifierProvider(create: (_) => UnitNotifier())
    ],
    child: App(),
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light()
          .copyWith(primaryColor: Colors.cyan, accentColor: Colors.cyanAccent),
      darkTheme: ThemeData.dark().copyWith(accentColor: Colors.cyanAccent),
      themeMode: Provider.of<ThemeModeNotifier>(context).mapThemeMode(),
      home: HomePage(),
    );
  }
}
