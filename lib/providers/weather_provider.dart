import 'package:weather/api/weather_api.dart';
import 'package:weather/model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class WeatherNotifier with ChangeNotifier {
  final WeatherApi weatherApi;
  Weather _weather;

  WeatherNotifier({this.weatherApi}) : assert(weatherApi != null) {
    loadWeatherData();
  }

  Weather get getWeather => _weather;

  Future<void> loadWeatherData() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
    );
    Weather weather = await weatherApi.getWeather(
      latitude: position.latitude,
      longitude: position.longitude,
    );
    if (_weather == weather) return;
    _weather = weather;
    notifyListeners();
  }
}
