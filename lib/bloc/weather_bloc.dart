import 'dart:async';

import 'package:aplikasi_cuaca/api/weather_api.dart';
import 'package:aplikasi_cuaca/bloc.dart';
import 'package:aplikasi_cuaca/models/forecast.dart';
import 'package:aplikasi_cuaca/models/weather.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherBloc implements Bloc {
  final getIt = GetIt.instance;
  var sp = SharedPreferences.getInstance();

  final _weatherController = BehaviorSubject<Weather?>();
  Stream<Weather?> get result => _weatherController.stream.asBroadcastStream();

  Future<void> fetchWeather(String name) async {
    try {
      _weatherController.add(null);
      Weather weather = await WeatherAPI().getWeather(name);
      _weatherController.add(weather);
      fetchForecast(weather.coord!.lat!, weather.coord!.lon!);
      addString(weather);
    } catch (e) {
      _weatherController.addError(e);
    }
    return;
  }

  final _forecastController = BehaviorSubject<Forecast?>();
  Stream<Forecast?> get foreResult =>
      _forecastController.stream.asBroadcastStream();

  Future<void> fetchForecast(double lat, double lon) async {
    Forecast forecast = await WeatherAPI().getForecast(lat, lon);
    _forecastController.add(forecast);
  }

  Future<void> addString(Weather weather) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('name', weather.name!);
  }

  Future<String> getString() async {
    var sp = await SharedPreferences.getInstance();
    String? name = sp.getString('name');
    fetchWeather(name!);
    return name;
  }

  @override
  void dispose() {}
}
