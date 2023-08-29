
import 'package:dartz/dartz.dart';
import 'package:weather/core/errors/failure.dart';
import 'package:weather/features/weatherPage/domain/entities/weatherEntity.dart';

abstract class WeatherRepository {
  
  Future<Either<Failure,WeatherEntity>> getWeather(String latitude,String longitude,String date);
}