//merupakan abstract kelas yang akan di implementasikan di layer data

import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entites/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
}
