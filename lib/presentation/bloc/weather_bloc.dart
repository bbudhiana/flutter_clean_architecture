import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entites/weather.dart';
import '../../domain/usecases/get_current_weather.dart';

import 'package:rxdart/rxdart.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather _getCurrentWeather;

  WeatherBloc(this._getCurrentWeather) : super(WeatherEmpty()) {
    on<OnCityChanged>(
      (event, emit) async {
        final cityName = event.cityName;

        emit(WeatherLoading());

        final result = await _getCurrentWeather.execute(cityName);

        result.fold(
          (failure) {
            emit(WeatherError(failure.message));
          },
          (data) {
            emit(WeatherHasData(data));
          },
        );
      },
      //restarable milik bloc_concurency
      //Using restartable() is a great way to keep your state up to date
      //with events that might still be processing when another event of the same type is added
      //Don't use it, however, if the value of previous results is important to your bloc!
      //We're using restartable() on the Load URL event so that only the latest loading
      //event will ever emit states, keeping our state nice and clean
      transformer: restartable(),
      //By debouncing, we mean that the bloc will only actually fire an event
      //if an event of the same type hasn't fired within a given duration
      //transformer: debounce(const Duration(microseconds: 1000)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
