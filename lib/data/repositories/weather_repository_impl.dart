import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/data/datasources/remote_data_source.dart';
import 'package:flutter_clean_architecture/data/exception.dart';
import 'package:flutter_clean_architecture/domain/entites/weather.dart';
import 'package:flutter_clean_architecture/data/failure.dart';
import 'package:flutter_clean_architecture/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final RemoteDataSource remoteDataSource;
  WeatherRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName) async {
    try {
      final result = await remoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to coonnect to the network'));
    }
  }
}
