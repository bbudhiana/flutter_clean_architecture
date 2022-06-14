//merupakan abstract kelas yang akan di implementasikan di layer presentation
//yaitu di area bloc : weather_bloc.dart

//DEFINITION :
//Use cases combine data from one or multiple repositories.
//The Use case is a class where you extract the business logic out of your Presenter/ViewModel
//This makes the Presenter/ViewModel simpler because it only coordinates the view and calls Use case
import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entites/weather.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  //gunakan or use repository (weather_repository.dart)
  GetCurrentWeather(this.repository);

  Future<Either<Failure, Weather>> execute(String cityName) {
    return repository.getCurrentWeather(cityName);
  }
}
