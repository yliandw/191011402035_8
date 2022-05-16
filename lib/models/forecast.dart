import 'package:json_annotation/json_annotation.dart';

part 'forecast.g.dart';

@JsonSerializable()
class Forecast {
  Forecast();
  List<ForecastList>? daily;
  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastToJson(this);
}

@JsonSerializable()
class ForecastList {
  ForecastList();
  ForecastTemp? temp;
  List<ForecastIcon>? weather;
  factory ForecastList.fromJson(Map<String, dynamic> json) =>
      _$ForecastListFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastListToJson(this);
}

@JsonSerializable()
class ForecastIcon {
  ForecastIcon();
  String? icon;
  factory ForecastIcon.fromJson(Map<String, dynamic> json) =>
      _$ForecastIconFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastIconToJson(this);
}

@JsonSerializable()
class ForecastTemp {
  ForecastTemp();

  double? min;
  double? max;
  factory ForecastTemp.fromJson(Map<String, dynamic> json) =>
      _$ForecastTempFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastTempToJson(this);
}
