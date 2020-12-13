import 'package:weather/model/weather_model.dart';
import 'package:weather/providers/unit_provider.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/utils/coverter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: Provider.of<WeatherNotifier>(context, listen: false)
            .loadWeatherData,
        child: Consumer2<WeatherNotifier, UnitNotifier>(
          builder: (_, weatherProvider, unitProvider, __) =>
              (weatherProvider.getWeather != null)
                  ? ListView(
                      children: [
                        WeatherGraphCard(
                          title: 'Hourly Forecast',
                          series: [
                            buildLineSeries(
                              name: 'Hourly',
                              weather: weatherProvider.getWeather.hourly,
                              unit: unitProvider.getUnit,
                            ),
                          ],
                        ),
                        WeatherGraphCard(
                          title: 'Daily Forecast',
                          isLegendVisible: true,
                          series: [
                            buildLineSeries(
                              name: 'Average',
                              weather: weatherProvider.getWeather.daily,
                              unit: unitProvider.getUnit,
                            ),
                            LineSeries<TemperatureData, DateTime>(
                              name: 'Min',
                              xAxisName: 'Time',
                              yAxisName: 'Temperature',
                              dataSource: weatherProvider.getWeather.daily
                                  .map(
                                    (dailyWeather) => TemperatureData(
                                      temperature: dailyWeather.minTemperature
                                          .asDouble(unitProvider.getUnit),
                                      time: DateTime.fromMillisecondsSinceEpoch(
                                          dailyWeather.time * 1000),
                                    ),
                                  )
                                  .toList(),
                              xValueMapper: (data, _) => data.time,
                              yValueMapper: (data, _) => data.temperature,
                            ),
                            LineSeries<TemperatureData, DateTime>(
                              name: 'Max',
                              xAxisName: 'Time',
                              yAxisName: 'Temperature',
                              dataSource: weatherProvider.getWeather.daily
                                  .map(
                                    (dailyWeather) => TemperatureData(
                                      temperature: dailyWeather.maxTemperature
                                          .asDouble(unitProvider.getUnit),
                                      time: DateTime.fromMillisecondsSinceEpoch(
                                          dailyWeather.time * 1000),
                                    ),
                                  )
                                  .toList(),
                              xValueMapper: (data, _) => data.time,
                              yValueMapper: (data, _) => data.temperature,
                            ),
                          ],
                        ),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
        ),
      ),
    );
  }

  LineSeries<TemperatureData, DateTime> buildLineSeries({
    @required String name,
    @required List<Weather> weather,
    @required Unit unit,
  }) {
    return LineSeries<TemperatureData, DateTime>(
      name: name,
      xAxisName: 'Time',
      yAxisName: 'Temperature',
      dataSource: weather
          .map(
            (weather) => TemperatureData(
              temperature: weather.temperature.asDouble(unit),
              time: DateTime.fromMillisecondsSinceEpoch(weather.time * 1000),
            ),
          )
          .toList(),
      xValueMapper: (data, _) => data.time,
      yValueMapper: (data, _) => data.temperature,
    );
  }
}

class WeatherGraphCard extends StatelessWidget {
  final String title;
  final List<LineSeries<TemperatureData, DateTime>> series;
  final bool isLegendVisible;

  WeatherGraphCard({
    Key key,
    @required this.title,
    @required this.series,
    this.isLegendVisible = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      child: Consumer<UnitNotifier>(
          builder: (_, unitProvider, __) => SfCartesianChart(
                primaryXAxis: DateTimeAxis(),
                title: ChartTitle(
                  text: title,
                  textStyle: TextStyle(fontSize: 24),
                ),
                legend: Legend(
                  isVisible: isLegendVisible,
                  isResponsive: true,
                  position: LegendPosition.bottom,
                ),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  format: 'point.x : point.y${getUnit(unitProvider.getUnit)}',
                ),
                enableAxisAnimation: true,
                onAxisLabelRender: (AxisLabelRenderArgs args) {
                  if (args.axisName == 'primaryYAxis')
                    args.text = '${args.value}${getUnit(unitProvider.getUnit)}';
                },
                series: series,
              )),
    );
  }

  String getUnit(Unit unit) {
    switch (unit) {
      case Unit.CELSIUS:
        return '\u2103';
      case Unit.FAHRENHEIT:
        return '\u2109';
      default:
        return '\u2103';
    }
  }
}

class TemperatureData {
  final DateTime time;
  final double temperature;
  TemperatureData({@required this.temperature, @required this.time});
}
