//merupakan abstract kelas yang akan di implementasikan di layer presentation
import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entites/weather.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  Future<Either<Failure, Weather>> execute(String cityName) {
    return repository.getCurrentWeather(cityName);
  }
}
