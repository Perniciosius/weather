import 'dart:convert';
import 'package:weather/api/api_key.dart';
import 'package:weather/api/http_exception.dart';
import 'package:weather/model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  final apiKey = Api.API_KEY;
  final baseUrl = 'https://api.openweathermap.org/data/2.5/onecall';
  final httpClient = http.Client();

  Future<Weather> getWeather({@required double latitude, @required double longitude}) async {
    final url = '$baseUrl?lat=$latitude&lon=$longitude&exclude=minutely&appid=$apiKey';
    final res = await httpClient.get(url);
    if (res.statusCode != 200) throw HTTPException(res.statusCode, 'Unable to fetch Weather Data.');
    final weatherJson = json.decode(res.body);
    return Weather.fromJson(weatherJson);
  }
}