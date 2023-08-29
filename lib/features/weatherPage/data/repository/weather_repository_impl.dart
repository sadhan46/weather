import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather/core/errors/exception.dart';
import 'package:weather/core/errors/failure.dart';
import 'package:weather/features/weatherPage/data/dataSources/remote_data_source.dart';
import 'package:weather/features/weatherPage/domain/entities/weatherEntity.dart';
import 'package:weather/features/weatherPage/domain/repositories/getWeather.dart';

class WeatherRepositoryImpl extends WeatherRepository {

  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future < Either < Failure, WeatherEntity >> getWeather(String latitude,String longitude,String date) async {
    try {
      final result = await weatherRemoteDataSource.getWeather(latitude,longitude,date);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}