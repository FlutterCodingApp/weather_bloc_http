import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_bloc_http/models/weather.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class WeatherChanged extends ThemeEvent {
  final WeatherCondition condition;

  const WeatherChanged({@required this.condition}) : assert(condition != null);

  @override
  List<Object> get props => [condition];
}
