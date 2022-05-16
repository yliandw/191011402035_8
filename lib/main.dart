import 'dart:io';

import 'package:aplikasi_cuaca/bloc/weather_bloc.dart';
import 'package:aplikasi_cuaca/models/forecast.dart';
import 'package:aplikasi_cuaca/models/weather.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
Future<void> setup() async {
  getIt.registerSingleton<WeatherBloc>(WeatherBloc());
}

void main() {
  setup();
  runApp(WeatherApp());
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  TextEditingController cityField = TextEditingController();
  String city = '';
  Future<void> checkLastLocation() async {
    var sp = await SharedPreferences.getInstance();
    WeatherBloc _weatherBloc = getIt<WeatherBloc>();
    if (sp.containsKey('name')) {
      cityField.text = await _weatherBloc.getString();
    }
  }

  @override
  void initState() {
    super.initState();
    checkLastLocation();
  }

  Future<void> onTextFieldSubmitted(String input) async {
    WeatherBloc _weatherBloc = getIt<WeatherBloc>();
    await _weatherBloc.fetchWeather(input);
  }

  @override
  Widget build(BuildContext context) {
    WeatherBloc _weatherBloc = getIt<WeatherBloc>();

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black54,
        body: StreamBuilder<Weather?>(
            stream: _weatherBloc.result,
            builder: (context, snapshot) {
              Weather? data = snapshot.data;
              return Container(
                decoration: (data != null)
                    ? BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'images/${data.weather!.first.main!.replaceAll(' ', '').toLowerCase()}.png'),
                            fit: BoxFit.cover))
                    : BoxDecoration(color: Colors.black87),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 300,
                      child: TextField(
                        onSubmitted: (String input) {
                          onTextFieldSubmitted(
                            input,
                          );
                        },
                        controller: cityField,
                        style: TextStyle(color: Colors.white, fontSize: 25),
                        decoration: InputDecoration(
                            hintText: 'Search another location...',
                            hintStyle:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(205, 218, 228, 2),
                                )),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    if (snapshot.hasError)
                      Padding(
                        padding: const EdgeInsets.only(right: 45.0, left: 45.0),
                        child: new Text(
                            'Sorry, we dont have data about this city. Try another one.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.red.shade500,
                                fontSize: Platform.isAndroid ? 30.0 : 25.0)),
                      ),
                    if (snapshot.connectionState == ConnectionState.active &&
                        data == null)
                      CircularProgressIndicator(),
                    if (data != null)
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Image.network(
                                    'http://openweathermap.org/img/wn/${data.weather!.first.icon}@2x.png',
                                    width: 100,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    data.weather!.first.main!,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30.0),
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Text(
                                data.main!.temp!.round().toString() + ' °C',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 50.0),
                              ),
                            ),
                            Center(
                              child: Text(
                                data.name!,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 40.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    StreamBuilder<Forecast?>(
                        stream: _weatherBloc.foreResult,
                        builder: (context, snapshot) {
                          Forecast? value = snapshot.data;
                          if (value == null) return Container();
                          return Container(
                            height: 175,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: value.daily!.length,
                              itemBuilder: (context, index) => forecastElement(
                                  index,
                                  value.daily![index].weather!.first.icon,
                                  value.daily![index].temp!.max!.round(),
                                  value.daily![index].temp!.min!.round()),
                            ),
                          );
                        }),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

Widget forecastElement(daysFromNow, iconIdF, maxTempForecast, minTempForecast) {
  var now = new DateTime.now();
  // ignore: non_constant_identifier_names
  var OneDayFromNow = now.add(new Duration(days: daysFromNow));
  return Padding(
    padding: const EdgeInsets.only(left: 15.0),
    child: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(205, 218, 228, 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              new DateFormat.E().format(OneDayFromNow),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              new DateFormat.MMMd().format(OneDayFromNow),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Image.network(
              'http://openweathermap.org/img/wn/$iconIdF@2x.png',
              width: 50,
            ),
            Text(
              'High: ' + maxTempForecast.toString() + ' °C',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            Text(
              'Low: ' + minTempForecast.toString() + ' °C',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ],
        ),
      ),
    ),
  );
}
