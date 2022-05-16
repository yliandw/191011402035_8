import 'dart:convert';

import 'package:aplikasi_cuaca/api/base_api.dart';
import 'package:aplikasi_cuaca/models/forecast.dart';
import 'package:aplikasi_cuaca/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherAPI extends BaseAPI {
  Future<Weather> getWeather(String name) async {
    final result = await http.Client().get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$name&appid=99a8cf26eee9509f58079f049cbc3f3a&units=metric'));

    if (result.statusCode != 200) throw Exception();
    return Weather.fromJson(json.decode(result.body));
  }

  Future<Forecast> getForecast(double lat, double lon) async {
    final foreResult = await http.Client().get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=current,minutely,hourly&appid=99a8cf26eee9509f58079f049cbc3f3a&units=metric'));

    if (foreResult.statusCode != 200) throw Exception();
    return Forecast.fromJson(json.decode(foreResult.body));
  }
}
