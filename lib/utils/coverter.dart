intToDouble(dynamic value) {
  if (value.runtimeType == double)
    return value;
  else if (value.runtimeType == int)
    return value.toDouble();
  else
    throw new Exception('$value is not of type int or double.');
}

enum Unit { CELSIUS, FAHRENHEIT }

class Temperature {
  final double _temperature;

  Temperature(this._temperature) : assert(_temperature != null);

  String get celsius => '${(_temperature - 273.15).round()}\u2103';

  String get fahrenheit => '${(_temperature * 9 / 5 - 459.67).round()}\u2109';

  double get celsiusAsDouble => intToDouble((_temperature - 273.15).round());

  double get fahrenheitAsDouble =>
      intToDouble((_temperature * 9 / 5 - 459.67).round());

  String as(Unit unit) {
    switch (unit) {
      case Unit.CELSIUS:
        return this.celsius;
      case Unit.FAHRENHEIT:
        return this.fahrenheit;
      default:
        return this.celsius;
    }
  }

  double asDouble(Unit unit) {
    switch (unit) {
      case Unit.CELSIUS:
        return this.celsiusAsDouble;
      case Unit.FAHRENHEIT:
        return this.fahrenheitAsDouble;
      default:
        return this.celsiusAsDouble;
    }
  }
}
