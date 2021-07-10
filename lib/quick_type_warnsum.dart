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
  
  JSON source (Weather Warning Summary):
  https://data.weather.gov.hk/weatherAPI/opendata/weather.php?dataType=warnsum&lang=tc
*/

import 'dart:convert';

WeatherWarningSummary hkoWeatherFromJson(String str) =>
    WeatherWarningSummary.fromJson(json.decode(str));

class WeatherWarningSummary {
  WeatherWarningSummary({this.data});

  List<Warning>? data;

  factory WeatherWarningSummary.fromJson(Map<String, dynamic> json) =>
      WeatherWarningSummary(
        data: List<Warning>.from(json.values.map(((v) => Warning.fromJson(v)))),
      );
}

class Warning {
  Warning({
    required this.name,
    required this.code,
    required this.actionCode,
    required this.type,
    required this.issueTime,
    required this.updateTime,
  });

  String name;
  String code;
  String actionCode;
  String? type;
  DateTime issueTime;
  DateTime updateTime;

  factory Warning.fromJson(Map<String, dynamic> json) => Warning(
        name: json["name"],
        code: json["code"],
        actionCode: json["actionCode"],
        type: json["type"],
        issueTime: DateTime.parse(json["issueTime"]).toLocal(),
        updateTime: DateTime.parse(json["updateTime"]).toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "actionCode": actionCode,
        "type": type,
        "issueTime": issueTime.toIso8601String(),
        "updateTime": updateTime.toIso8601String(),
      };
}
