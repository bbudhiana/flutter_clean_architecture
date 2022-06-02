import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entites/weather.dart';

class CuacaModel extends Equatable {
  final String cityName;
  final String main;
  final String description;
  final String iconCode;
  final double temperature;
  final int pressure;
  final int humidity;

  const CuacaModel({
    required this.cityName,
    required this.main,
    required this.description,
    required this.iconCode,
    required this.temperature,
    required this.pressure,
    required this.humidity,
  });

  CuacaModel copyWith({
    String? cityName,
    String? main,
    String? description,
    String? iconCode,
    double? temperature,
    int? pressure,
    int? humidity,
  }) {
    return CuacaModel(
      cityName: cityName ?? this.cityName,
      main: main ?? this.main,
      description: description ?? this.description,
      iconCode: iconCode ?? this.iconCode,
      temperature: temperature ?? this.temperature,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({
      'weather': [
        {
          'main': main,
          'description': description,
          'icon': iconCode,
        }
      ],
      'main': {
        'temp': temperature,
        'pressure': pressure,
        'humidity': humidity,
      },
      'name': cityName,
    });

    /* result.addAll({'cityName': cityName});
    result.addAll({'main': main});
    result.addAll({'description': description});
    result.addAll({'iconCode': iconCode});
    result.addAll({'temperature': temperature});
    result.addAll({'pressure': pressure});
    result.addAll({'humidity': humidity}); */

    return result;
  }

  factory CuacaModel.fromMap(Map<String, dynamic> map) {
    return CuacaModel(
      cityName: map['cityName'] ?? '',
      main: map['weather'][0]['main'] ?? '',
      description: map['weather'][0]['description'] ?? '',
      iconCode: map['weather'][0]['icon'] ?? '',
      temperature: map['main']['temp']?.toDouble() ?? 0.0,
      pressure: map['main']['pressure']?.toInt() ?? 0,
      humidity: map['main']['humidity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CuacaModel.fromJson(String source) =>
      CuacaModel.fromMap(json.decode(source));

  //dari Object Model to Object Entiti
  Weather toEntity() => Weather(
        cityName: cityName,
        main: main,
        description: description,
        iconCode: iconCode,
        temperature: temperature,
        pressure: pressure,
        humidity: humidity,
      );

  @override
  String toString() {
    return 'CuacaModel(cityName: $cityName, main: $main, description: $description, iconCode: $iconCode, temperature: $temperature, pressure: $pressure, humidity: $humidity)';
  }

  @override
  List<Object> get props {
    return [
      cityName,
      main,
      description,
      iconCode,
      temperature,
      pressure,
      humidity,
    ];
  }
}
