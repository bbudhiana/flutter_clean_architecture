import 'package:flutter_clean_architecture/data/datasources/remote_data_source.dart';
import 'package:flutter_clean_architecture/domain/repositories/weather_repository.dart';

import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

//flutter pub run build_runner build
@GenerateMocks([
  WeatherRepository,
  RemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
