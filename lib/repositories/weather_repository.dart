import 'dart:async';

import 'package:meta/meta.dart';

import 'package:weather_bloc_http/repositories/weather_api_client.dart';
import 'package:weather_bloc_http/models/models.dart';
import 'package:weather_bloc_http/models/weather.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  Future<Weather> getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);
    return weatherApiClient.fetchWeather(locationId);
  }
}
