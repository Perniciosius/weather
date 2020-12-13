import 'dart:math';

import 'package:weather/model/weather_model.dart';
import 'package:weather/providers/unit_provider.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/utils/coverter.dart';
import 'package:weather/utils/gradients.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CurrentWeather extends StatefulWidget {
  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    Weather weather = Provider.of<WeatherNotifier>(context).getWeather;
    Unit unit = Provider.of<UnitNotifier>(context).getUnit;

    return (weather != null)
        ? RefreshIndicator(
            onRefresh: Provider.of<WeatherNotifier>(context, listen: false)
                .loadWeatherData,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: BoxDecoration(
                      gradient: gradients[Random().nextInt(gradients.length)],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            weather.temperature.as(unit),
                            style: TextStyle(fontSize: 75 / textScaleFactor),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(top: 10),
                        //   child: Text(
                        //     'Feels like ${weather.temperatureFeelsLike.as(unit)}',
                        //     style: TextStyle(fontSize: 15 / textScaleFactor),
                        //   ),
                        // ),
                        Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Icon(
                              weather.getIconData(),
                              color: Colors.amber,
                              size: 60.0,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            '${weather.main}',
                            style: TextStyle(fontSize: 34 / textScaleFactor),
                          ),
                        ),
                        Table(
                          children: [
                            TableRow(children: [
                              buildWeatherTile(
                                title: 'Feels Like',
                                data: '${weather.temperature.as(unit)}',
                              ),
                              buildWeatherTile(
                                title: 'Sunrise',
                                data:
                                    '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(weather.sunrise * 1000))}',
                              ),
                              buildWeatherTile(
                                title: 'Sunset',
                                data:
                                    '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(weather.sunset * 1000))}',
                              ),
                            ]),
                            TableRow(children: [
                              buildWeatherTile(
                                title: 'Humidity',
                                data: '${weather.humidity}%',
                              ),
                              buildWeatherTile(
                                title: 'Wind Speed',
                                data: '${weather.windSpeed} mph',
                              ),
                              buildWeatherTile(
                                title: 'Pressure',
                                data: '${weather.pressure.floor()} hPa',
                              ),
                            ]),
                            TableRow(children: [
                              buildWeatherTile(
                                title: 'Min. Temp.',
                                data: '${weather.minTemperature.as(unit)}',
                              ),
                              buildWeatherTile(
                                title: 'Max. Temp.',
                                data: '${weather.maxTemperature.as(unit)}',
                              ),
                              buildWeatherTile(
                                title: 'UV Index',
                                data: '${weather.uvIndex}',
                              ),
                            ]),
                          ],
                        ),
                        SizedBox(height: 30.0)
                      ],
                    ),
                  ),
                ),
                WeatherTitle(
                  title: 'Next 24 Hours',
                  textScaleFactor: textScaleFactor,
                ),
                Container(
                  height: 170,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: weather.hourly.length,
                    itemBuilder: (context, index) {
                      final hourly = weather.hourly[index];

                      return SizedBox(
                        width: 180,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              gradient: gradients[
                                  Random().nextInt(gradients.length)]),
                          margin: EdgeInsets.only(left: 25.0, right: 10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(hourly.time * 1000))}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15 / textScaleFactor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Icon(hourly.getIconData()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(hourly.main),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    hourly.temperature.as(unit),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25 / textScaleFactor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                WeatherTitle(
                  title: 'Next 7 Days',
                  textScaleFactor: textScaleFactor,
                ),
                Container(
                  height: 210,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: weather.daily.length,
                    itemBuilder: (context, index) {
                      final daily = weather.daily[index];
                      return SizedBox(
                        width: 180,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              gradient: gradients[
                                  Random().nextInt(gradients.length)]),
                          margin: EdgeInsets.only(left: 25.0, right: 10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '${DateFormat.EEEE().format(DateTime.fromMillisecondsSinceEpoch(daily.time * 1000))}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15 / textScaleFactor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Icon(daily.getIconData()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text('${daily.main}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    daily.temperature.as(unit),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25 / textScaleFactor),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          daily.minTemperature.as(unit),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          daily.maxTemperature.as(unit),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.0)
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  ListTile buildWeatherTile({@required String title, @required String data}) {
    return ListTile(
      subtitle: Text(title),
      title: Text(data),
    );
  }
}

class WeatherTitle extends StatelessWidget {
  WeatherTitle({
    Key key,
    @required this.title,
    @required this.textScaleFactor,
  }) : super(key: key);

  final String title;
  final double textScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, bottom: 20.0, left: 25.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 25 / textScaleFactor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
