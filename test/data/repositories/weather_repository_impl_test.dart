import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/data/exception.dart';
import 'package:flutter_clean_architecture/data/failure.dart';
import 'package:flutter_clean_architecture/data/models/weather_model.dart';
import 'package:flutter_clean_architecture/data/repositories/weather_repository_impl.dart';
import 'package:flutter_clean_architecture/domain/entites/weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late WeatherRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = WeatherRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  const tWeatherModel = WeatherModel(
    cityName: 'Jakarta',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const tWeather = Weather(
    cityName: 'Jakarta',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  group('get current weather', () {
    const tCityName = 'Jakarta';

    test(
      'should return current weather when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getCurrentWeather(tCityName))
            .thenAnswer((_) async => tWeatherModel);

        // act
        final result = await repository.getCurrentWeather(tCityName);

        // assert
        verify(mockRemoteDataSource.getCurrentWeather(tCityName));
        expect(result, equals(const Right(tWeather)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getCurrentWeather(tCityName))
            .thenThrow(ServerException());

        // act
        final result = await repository.getCurrentWeather(tCityName);

        // assert
        verify(mockRemoteDataSource.getCurrentWeather(tCityName));
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockRemoteDataSource.getCurrentWeather(tCityName)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getCurrentWeather(tCityName);

        // assert
        verify(mockRemoteDataSource.getCurrentWeather(tCityName));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });
}
