import '../data/datasources/remote_data_source.dart';
import '../data/repositories/weather_repository_impl.dart';
import '../domain/repositories/weather_repository.dart';
import '../domain/usecases/get_current_weather.dart';
import '../presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory<WeatherBloc>(() => WeatherBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentWeather(locator()));

  // repository
  // disinilah yang menyambungkan WeatherRepository dengan implementasinya, yaitu WeatherRepositoryImpl
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data source jika pake weather model
  /* locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      client: locator(),
    ),
  ); */

  //data source jika pake cuaca model
  //bacanya : jika ada menggunakan yang RemoteDataSource maka yg dipakai adalah RemoteDataSourceCuacaImpl
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceCuacaImpl(
      client: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
