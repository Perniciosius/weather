import 'package:weather/utils/coverter.dart';
import 'package:weather/utils/weather_icon_mapper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Weather extends Equatable {
  final int id;
  final int time;
  final int sunrise;
  final int sunset;
  final int humidity;
  final int windDegree;

  final String description;
  final String iconCode;
  final String main;

  final double windSpeed;
  final double pressure;
  final double uvIndex;
  final double latitude;
  final double longitude;

  final Temperature temperature;
  final Temperature temperatureFeelsLike;
  final Temperature maxTemperature;
  final Temperature minTemperature;

  final List<Weather> hourly;
  final List<Weather> daily;

  Weather({
    this.id,
    this.time,
    this.sunrise,
    this.sunset,
    this.humidity,
    this.description,
    this.iconCode,
    this.main,
    this.windSpeed,
    this.windDegree,
    this.temperature,
    this.temperatureFeelsLike,
    this.maxTemperature,
    this.minTemperature,
    this.pressure,
    this.uvIndex,
    this.latitude,
    this.longitude,
    this.hourly,
    this.daily,
  });

  @override
  List<Object> get props => [
        time,
        sunrise,
        sunset,
        humidity,
        description,
        iconCode,
        main,
        windSpeed,
        windDegree,
        temperature,
        temperatureFeelsLike,
        maxTemperature,
        minTemperature,
        pressure,
        uvIndex,
        latitude,
        longitude,
        hourly,
        daily,
      ];

  static Weather fromJson(Map<String, dynamic> json) {
    final hourlyWeather = List<Weather>();
    for (final item in json['hourly']) {
      hourlyWeather.add(Weather(
        id: item['weather'][0]['id'],
        time: item['dt'],
        temperature: Temperature(intToDouble(item['temp'])),
        temperatureFeelsLike: Temperature(intToDouble(item['feels_like'])),
        humidity: item['humidity'],
        pressure: intToDouble(item['pressure']),
        windSpeed: intToDouble(item['wind_speed']),
        windDegree: item['wind_degree'],
        iconCode: item['weather'][0]['icon'],
        main: item['weather'][0]['main'],
      ));
    }

    final dailyWeather = List<Weather>();
    for (final item in json['daily']) {
      dailyWeather.add(Weather(
        id: item['weather'][0]['id'],
        time: item['dt'],
        sunrise: item['sunrise'],
        sunset: item['sunset'],
        temperature: Temperature(intToDouble(item['temp']['day'])),
        temperatureFeelsLike:
            Temperature(intToDouble(item['feels_like']['day'])),
        minTemperature: Temperature(intToDouble(item['temp']['min'])),
        maxTemperature: Temperature(intToDouble(item['temp']['max'])),
        pressure: intToDouble(item['pressure']),
        humidity: item['humidity'],
        uvIndex: intToDouble(item['uvi']),
        main: item['weather'][0]['main'],
        iconCode: item['weather'][0]['icon'],
        windSpeed: intToDouble(item['wind_speed']),
        windDegree: item['wind_degree'],
      ));
    }

    final weather = json['current']['weather'][0];
    return Weather(
        id: weather['id'],
        time: json['current']['dt'],
        description: weather['description'],
        iconCode: weather['icon'],
        main: weather['main'],
        temperature: Temperature(intToDouble(json['current']['temp'])),
        temperatureFeelsLike:
            Temperature(intToDouble(json['current']['feels_like'])),
        maxTemperature:
            Temperature(intToDouble(json['daily'][0]['temp']['max'])),
        minTemperature:
            Temperature(intToDouble(json['daily'][0]['temp']['min'])),
        pressure: intToDouble(json['current']['pressure']),
        sunrise: json['current']['sunrise'],
        sunset: json['current']['sunset'],
        humidity: json['current']['humidity'],
        windSpeed: intToDouble(json['current']['wind_speed']),
        windDegree: json['current']['wind_degree'],
        uvIndex: intToDouble(json['current']['uvi']),
        latitude: intToDouble(json['lat']),
        longitude: intToDouble(json['lon']),
        daily: dailyWeather,
        hourly: hourlyWeather);
  }

  IconData getIconData() {
    switch (this.iconCode) {
      case '01d':
        return WeatherIcons.clear_day;
      case '01n':
        return WeatherIcons.clear_night;
      case '02d':
        return WeatherIcons.few_clouds_day;
      case '02n':
        return WeatherIcons.few_clouds_night;
      case '03d':
      case '04d':
      case '03n':
      case '04n':
        return WeatherIcons.clouds;
      case '09d':
        return WeatherIcons.shower_rain_day;
      case '09n':
        return WeatherIcons.shower_rain_night;
      case '10d':
        return WeatherIcons.rain_day;
      case '10n':
        return WeatherIcons.rain_night;
      case '11d':
        return WeatherIcons.thunder_storm_day;
      case '11n':
        return WeatherIcons.thunder_storm_night;
      case '13d':
        return WeatherIcons.snow_day;
      case '13n':
        return WeatherIcons.snow_night;
      case '50d':
        return WeatherIcons.mist_day;
      case '50n':
        return WeatherIcons.mist_night;
      default:
        return WeatherIcons.clear_day;
    }
  }
}
