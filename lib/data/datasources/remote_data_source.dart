import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants.dart';
import '../exception.dart';
import '../models/cuaca_model.dart';
import '../models/weather_model.dart';

/* abstract class RemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

abstract class RemoteDataSourceCuaca {
  Future<CuacaModel> getCurrentWeather(String cityName);
} */

abstract class RemoteDataSource<T> {
  Future<T> getCurrentWeather(String cityName);
}

class RemoteDataSourceImpl implements RemoteDataSource<WeatherModel> {
  late final http.Client client;
  RemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}

class RemoteDataSourceCuacaImpl implements RemoteDataSource<CuacaModel> {
  late final http.Client client;
  RemoteDataSourceCuacaImpl({required this.client});

  @override
  Future<CuacaModel> getCurrentWeather(String cityName) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));

    if (response.statusCode == 200) {
      return CuacaModel.fromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
