import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  
  const WeatherEntity({
    required this.minTemperature,
    required this.maxTemperature,
    required this.precipitation,
  });

  final double minTemperature;
  final double maxTemperature;
  final double precipitation;

  @override
  List < Object ? > get props => [
    minTemperature,
    maxTemperature,
    precipitation,
  ];
}