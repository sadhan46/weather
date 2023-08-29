import 'dart:convert';

import 'package:weather/core/constants/constants.dart';
import 'package:weather/core/errors/exception.dart';
import 'package:http/http.dart' as http;
import 'package:weather/features/weatherPage/data/models/weatherModel.dart';

abstract class WeatherRemoteDataSource {
  
  Future<WeatherModel> getWeather(String latitude,String longitude,String date);
}


class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final http.Client client;
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future < WeatherModel > getWeather(String latitude,String longitude,String date) async {
    final response =
      await client.get(Uri.parse(Urls.weatherByPosition(latitude,longitude,date)));
      print('------------------------------------------------');
        print(response);
        print(response.body);
     if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}