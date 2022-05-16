// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityName _$CityNameFromJson(Map<String, dynamic> json) {
  return CityName(
    json['name'] as String,
  );
}

Map<String, dynamic> _$CityNameToJson(CityName instance) => <String, dynamic>{
      'name': instance.name,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather()
    ..name = json['name'] as String?
    ..cityName = json['cityName'] == null
        ? null
        : CityName.fromJson(json['cityName'] as Map<String, dynamic>)
    ..coord = json['coord'] == null
        ? null
        : WeatherCoor.fromJson(json['coord'] as Map<String, dynamic>)
    ..main = json['main'] == null
        ? null
        : WeatherMain.fromJson(json['main'] as Map<String, dynamic>)
    ..weather = (json['weather'] as List<dynamic>?)
        ?.map((e) => WeatherDetail.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'name': instance.name,
      'cityName': instance.cityName,
      'coord': instance.coord,
      'main': instance.main,
      'weather': instance.weather,
    };

WeatherCoor _$WeatherCoorFromJson(Map<String, dynamic> json) {
  return WeatherCoor()
    ..lat = (json['lat'] as num?)?.toDouble()
    ..lon = (json['lon'] as num?)?.toDouble();
}

Map<String, dynamic> _$WeatherCoorToJson(WeatherCoor instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
    };

WeatherMain _$WeatherMainFromJson(Map<String, dynamic> json) {
  return WeatherMain()..temp = (json['temp'] as num?)?.toDouble();
}

Map<String, dynamic> _$WeatherMainToJson(WeatherMain instance) =>
    <String, dynamic>{
      'temp': instance.temp,
    };

WeatherDetail _$WeatherDetailFromJson(Map<String, dynamic> json) {
  return WeatherDetail()
    ..main = json['main'] as String?
    ..icon = json['icon'] as String?;
}

Map<String, dynamic> _$WeatherDetailToJson(WeatherDetail instance) =>
    <String, dynamic>{
      'main': instance.main,
      'icon': instance.icon,
    };
