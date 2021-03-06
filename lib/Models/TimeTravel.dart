import 'dart:convert';

import 'package:buzzride/Util/Util.dart';
import 'package:http/http.dart' as http;

class TimeTravel {
  TimeTravel({this.distance, this.time});

  String? distance, time, country, lat, long;

  factory TimeTravel.fromJson(Map<String, dynamic> json) =>
      TimeTravel(distance: json['distance'], time: json['time']);

  Future<TimeTravel> getDistance(
      {required String lat1,
      required String long1,
      required String lat2,
      required String long2}) async {
    Uri url = Uri.parse(
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${lat1},${long1}&destinations=${lat2},${long2}&key=${google_api_key}");
    // print(url);
    // print(toMap());
    return await http
        .get(url, headers: {"Content-Type": "Application/json"}).then((res) {
      var rs = jsonDecode(res.body),
          distance = rs['rows'][0]['elements'][0]['distance']['text'],
          time = rs['rows'][0]['elements'][0]['duration']['text'];

      if (res.statusCode == 200) {
        return TimeTravel.fromJson({"distance": distance, 'time': time});
      } else {
        return TimeTravel.fromJson({"distance": distance, 'time': time});
      }
    });
  }
}
