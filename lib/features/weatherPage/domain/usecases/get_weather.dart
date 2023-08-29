import 'package:dartz/dartz.dart';
import 'package:weather/core/errors/failure.dart';
import 'package:weather/features/weatherPage/domain/entities/weatherEntity.dart';
import 'package:weather/features/weatherPage/domain/repositories/getWeather.dart';

class GetWeatherUseCase {

  final WeatherRepository weatherRepository;

  GetWeatherUseCase(this.weatherRepository); 
  
  Future<Either<Failure,WeatherEntity>> execute(String latitude,String longitude,String date) {
    return weatherRepository.getWeather(latitude,longitude,date);
  }
}