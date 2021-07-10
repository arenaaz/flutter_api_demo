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

  Reference:
  * https://flutter.dev/docs/cookbook/networking/fetch-data
*/

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'quick_type_rhrread.dart';
import 'quick_type_warnsum.dart';

const String hkoWeatherAPIURL =
    'https://data.weather.gov.hk/weatherAPI/opendata/weather.php';
const String hkoWeatherIconDir =
    'https://www.hko.gov.hk/images/HKOWxIconOutline/';

/*
 * Icon list: https://www.hko.gov.hk/textonly/v2/explain/wxicon_e.htm
 */
const hkoWarningIconDir = 'https://www.hko.gov.hk/tc/wxinfo/dailywx/images/';
const hkoWarningIconMap = {
  '酷熱天氣警告': 'vhot.gif',
  '黃色暴雨警告信號': 'raina.gif',
  '紅色暴雨警告信號': 'rainr.gif',
  '黑色暴雨警告信號': 'rainb.gif',
  '一號戒備信號': 'tc1.gif',
  '三號強風信號': 'tc3.gif',
  '八號東南烈風或暴風信號': 'tc8b.gif',
  '八號西南烈風或暴風信號': 'tc8c.gif',
  '八號東北烈風或暴風信號': 'tc8ne.gif',
  '八號西北烈風或暴風信號': 'tc8d.gif',
  '九號烈風或暴風風力增強信號': 'tc9.gif',
  '十號颶風信號': 'tc10.gif',
  '雷暴警告': 'ts.gif',
  '新界北部水浸特別報告': 'ntfl.gif',
  '山泥傾瀉警告': 'landslip.gif',
  '寒冷天氣警告': 'cold.gif',
  '強烈季候風信號': 'sms.gif',
  '霜凍警告': 'frost.gif',
  '紅色火災危險警告': 'firer.gif',
  '黃色火災危險警告': 'firey.gif',
  '海嘯警告': 'tsunami-warn.gif'
};

const _titleStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
const _bigNumberStyle = TextStyle(fontSize: 60, fontWeight: FontWeight.bold);
const _normalStyle = TextStyle(fontSize: 18);
const _smallStyle = TextStyle(fontSize: 15);
const _tooltipStyle = TextStyle(fontSize: 18, color: Colors.white);

void main() => runApp(const MyApp());

Future<Map<String, dynamic>> fetchWeatherData(var type, var lang) async {
  var response =
      await http.get(Uri.parse('$hkoWeatherAPIURL?dataType=$type&lang=$lang'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Unable to fetch weather data');
  }
}

Future<CurrentWeatherReport> fetchCurrentWeatherReport() async =>
    CurrentWeatherReport.fromJson(await fetchWeatherData('rhrread', 'tc'));

Future<WeatherWarningSummary> fetchWeatherWarningSummary() async =>
    WeatherWarningSummary.fromJson(await fetchWeatherData('warnsum', 'tc'));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter API Demo',
      home: MyHomePage(title: 'Flutter API Demo'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<CurrentWeatherReport> wdCurrent;
  late Future<WeatherWarningSummary> wdWarning;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future refresh() {
    setState(() {
      wdCurrent = fetchCurrentWeatherReport();
      wdWarning = fetchWeatherWarningSummary();
    });
    return wdCurrent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: refresh, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: FutureBuilder(
              future: wdWarning,
              builder:
                  (context, AsyncSnapshot<WeatherWarningSummary> snapshot) {
                print(
                    '{build} snapshot: error: ${snapshot.hasError}, data: ${snapshot.hasData}, connectionState: ${snapshot.connectionState}');
                if (snapshot.hasError) return Text("${snapshot.error}");
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return buildWeatherWarningSummary(snapshot.data!);
                }
                return buildLoading();
              },
            ),
          ),
          Center(
            child: FutureBuilder(
              future: wdCurrent,
              builder: (context, AsyncSnapshot<CurrentWeatherReport> snapshot) {
                if (snapshot.hasError) return Text("${snapshot.error}");
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return buildCurrentWeatherReport(snapshot.data!);
                }
                return buildLoading();
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding buildLoading() {
    return const Padding(
      padding: EdgeInsets.all(32.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildCurrentWeatherReport(CurrentWeatherReport data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('本地天氣報告', style: _titleStyle),
              Text('${DateFormat('HH:mm').format(data.updateTime)} 更新',
                  style: _smallStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${data.temperature.data.first.value}℃',
                      style: _bigNumberStyle),
                  Text('${data.humidity.data.first.value}%',
                      style: _bigNumberStyle),
                ],
              ),
              for (var i = 0; i < data.icon.length; i++)
                Image.network(
                  '$hkoWeatherIconDir/pic${data.icon.elementAt(i)}.png',
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildWeatherWarningSummary(WeatherWarningSummary data) {
    var temp;
    if ((temp = data.data) != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Row(
          children: [
            for (int i = 0; i < temp!.length; i++)
              if (hkoWarningIconMap.containsKey(temp!.elementAt(i).name))
                Tooltip(
                  preferBelow: false,
                  padding: const EdgeInsets.all(8.0),
                  textStyle: _tooltipStyle,
                  message: warningName(temp, i),
                  child: Image.network(
                    '$hkoWarningIconDir${hkoWarningIconMap[temp!.elementAt(i).name]}',
                  ),
                )
              else
                Text(warningName(temp, i), style: _normalStyle),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  String warningName(temp, int i) {
    return temp.elementAt(i).name +
        (temp.elementAt(i).type != null ? '：${temp.elementAt(i).type}' : '');
  }
}
