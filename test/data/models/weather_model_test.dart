import 'dart:convert';

import 'package:flutter_clean_architecture/data/models/weather_model.dart';
import 'package:flutter_clean_architecture/domain/entites/weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main() {
  //Data Model
  const tWeatherModel = WeatherModel(
    cityName: 'Jakarta',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  //Entiti
  const tWeather = Weather(
    cityName: 'Jakarta',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  //Is the model that we have created equal with the entities at the domain layer?
  group('to entity', () {
    test(
      'should be a subclass of weather entity',
      () async {
        // assert
        final result = tWeatherModel.toEntity();
        expect(result, equals(tWeather));
      },
    );
  });

  //Does the fromJson() function return a valid model?
  group('from json', () {
    test(
      'should return a valid model from json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          readJson('helpers/dummy_data/dummy_weather_response.json'),
        );

        // act
        final result = WeatherModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tWeatherModel));
      },
    );
  });

  //Does the toJson() function returns the appropriate JSON map?
  group('to json', () {
    test(
      'should return a json map containing proper data',
      () async {
        // act
        final result = tWeatherModel.toJson();

        // assert
        final expectedJsonMap = {
          'weather': [
            {
              'main': 'Clouds',
              'description': 'few clouds',
              'icon': '02d',
            }
          ],
          'main': {
            'temp': 302.28,
            'pressure': 1009,
            'humidity': 70,
          },
          'name': 'Jakarta',
        };
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
