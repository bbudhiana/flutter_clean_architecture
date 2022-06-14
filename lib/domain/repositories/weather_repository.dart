//merupakan abstract kelas yang akan di implementasikan di layer data

import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entites/weather.dart';

//berbasis pada output, kemungkinan output ada 2 : Weather (entity) or Failure
abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
}
