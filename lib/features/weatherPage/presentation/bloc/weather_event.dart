import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class OnPosition extends WeatherEvent {
  final String latitude;
  final String longitude;
  final String date;

  const OnPosition(this.latitude,this.longitude,this.date);

  @override
  List<Object?> get props => [latitude,longitude,date];
}