import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:weather/features/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/weatherPage/data/dataSources/remote_data_source.dart';
import 'package:weather/features/weatherPage/data/repository/weather_repository_impl.dart';
import 'package:weather/features/weatherPage/domain/repositories/getWeather.dart';
import 'package:weather/features/weatherPage/domain/usecases/get_weather.dart';

final locator = GetIt.instance;

void setupLocator() {

  // bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetWeatherUseCase(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      weatherRemoteDataSource: locator()
    ),
  );

  // data source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  
  // external
  locator.registerLazySingleton(() => http.Client());

  
  
}