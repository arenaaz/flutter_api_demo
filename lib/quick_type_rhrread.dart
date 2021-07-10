/*
  Flutter API Demo
  Copyright (C) 2021  Alan Hui

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.

  This file was generated with quicktype (https://app.quicktype.io/) and
  modified.
  
  JSON source (Current Weather Report):
  https://data.weather.gov.hk/weatherAPI/opendata/weather.php?dataType=rhrread
*/

import 'dart:convert';

CurrentWeatherReport hkoWeatherFromJson(String str) =>
    CurrentWeatherReport.fromJson(json.decode(str));

String hkoWeatherToJson(CurrentWeatherReport data) =>
    json.encode(data.toJson());

safeList(Map json, String key) =>
    isSafe(json, key) ? List<String>.from(json[key]) : null;

isSafe(Map json, String key) => (json.containsKey(key) && json[key] != '');

class CurrentWeatherReport {
  CurrentWeatherReport({
    required this.rainfall,
    required this.warningMessage,
    required this.icon,
    required this.iconUpdateTime,
    required this.uvindex,
    required this.updateTime,
    required this.temperature,
    required this.tcmessage,
    required this.mintempFrom00To09,
    required this.rainfallFrom00To12,
    required this.rainfallLastMonth,
    required this.rainfallJanuaryToLastMonth,
    required this.humidity,
  });

  Rainfall? rainfall;
  List<String>? warningMessage;
  List<int> icon;
  DateTime iconUpdateTime;
  Uvindex? uvindex;
  DateTime updateTime;
  Humidity temperature;
  List<String>? tcmessage;
  String mintempFrom00To09;
  String rainfallFrom00To12;
  String rainfallLastMonth;
  String rainfallJanuaryToLastMonth;
  Humidity humidity;

  factory CurrentWeatherReport.fromJson(Map<String, dynamic> json) =>
      CurrentWeatherReport(
        rainfall: isSafe(json, "rainfall")
            ? Rainfall.fromJson(json["rainfall"])
            : null,
        warningMessage: safeList(json, "warningMessage"),
        icon: List<int>.from(json["icon"].map((x) => x)),
        iconUpdateTime: DateTime.parse(json["iconUpdateTime"]).toLocal(),
        uvindex:
            isSafe(json, "uvindex") ? Uvindex.fromJson(json["uvindex"]) : null,
        updateTime: DateTime.parse(json["updateTime"]).toLocal(),
        temperature: Humidity.fromJson(json["temperature"]),
        tcmessage: safeList(json, "tcmessage"),
        mintempFrom00To09: json["mintempFrom00To09"],
        rainfallFrom00To12: json["rainfallFrom00To12"],
        rainfallLastMonth: json["rainfallLastMonth"],
        rainfallJanuaryToLastMonth: json["rainfallJanuaryToLastMonth"],
        humidity: Humidity.fromJson(json["humidity"]),
      );

  Map<String, dynamic> toJson() => {
        "rainfall": rainfall?.toJson(),
        "warningMessage": warningMessage == null
            ? null
            : List<dynamic>.from(warningMessage!.map((x) => x)),
        "icon": List<dynamic>.from(icon.map((x) => x)),
        "iconUpdateTime": iconUpdateTime.toIso8601String(),
        "uvindex": uvindex?.toJson(),
        "updateTime": updateTime.toIso8601String(),
        "temperature": temperature.toJson(),
        "tcmessage": tcmessage,
        "mintempFrom00To09": mintempFrom00To09,
        "rainfallFrom00To12": rainfallFrom00To12,
        "rainfallLastMonth": rainfallLastMonth,
        "rainfallJanuaryToLastMonth": rainfallJanuaryToLastMonth,
        "humidity": humidity.toJson(),
      };
}

class Humidity {
  Humidity({
    required this.recordTime,
    required this.data,
  });

  DateTime recordTime;
  List<HumidityDatum> data;

  factory Humidity.fromJson(Map<String, dynamic> json) => Humidity(
        recordTime: DateTime.parse(json["recordTime"]).toLocal(),
        data: List<HumidityDatum>.from(
            json["data"].map((x) => HumidityDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recordTime": recordTime.toIso8601String(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class HumidityDatum {
  HumidityDatum({
    required this.unit,
    required this.value,
    required this.place,
  });

  String unit;
  int value;
  String place;

  factory HumidityDatum.fromJson(Map<String, dynamic> json) => HumidityDatum(
        unit: json["unit"],
        value: json["value"],
        place: json["place"],
      );

  Map<String, dynamic> toJson() => {
        "unit": unit,
        "value": value,
        "place": place,
      };
}

class Rainfall {
  Rainfall({
    required this.data,
    required this.startTime,
    required this.endTime,
  });

  List<RainfallDatum> data;
  DateTime startTime;
  DateTime endTime;

  factory Rainfall.fromJson(Map<String, dynamic> json) => Rainfall(
        data: List<RainfallDatum>.from(
            json["data"].map((x) => RainfallDatum.fromJson(x))),
        startTime: DateTime.parse(json["startTime"]).toLocal(),
        endTime: DateTime.parse(json["endTime"]).toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
      };
}

class RainfallDatum {
  RainfallDatum({
    required this.unit,
    required this.place,
    required this.max,
    required this.main,
  });

  String unit;
  String place;
  int max;
  String main;

  factory RainfallDatum.fromJson(Map<String, dynamic> json) => RainfallDatum(
        unit: json["unit"],
        place: json["place"],
        max: json["max"],
        main: json["main"],
      );

  Map<String, dynamic> toJson() => {
        "unit": unit,
        "place": place,
        "max": max,
        "main": main,
      };
}

class Uvindex {
  Uvindex({
    required this.data,
    required this.recordDesc,
  });

  List<UvindexDatum> data;
  String recordDesc;

  factory Uvindex.fromJson(Map<String, dynamic> json) => Uvindex(
        data: List<UvindexDatum>.from(
            json["data"].map((x) => UvindexDatum.fromJson(x))),
        recordDesc: json["recordDesc"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "recordDesc": recordDesc,
      };
}

class UvindexDatum {
  UvindexDatum({
    required this.place,
    required this.value,
    required this.desc,
  });

  String place;
  int value;
  String desc;

  factory UvindexDatum.fromJson(Map<String, dynamic> json) => UvindexDatum(
        place: json["place"],
        value: json["value"].toInt(),
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "place": place,
        "value": value,
        "desc": desc,
      };
}
