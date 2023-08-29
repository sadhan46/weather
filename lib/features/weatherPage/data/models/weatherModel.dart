import 'package:weather/features/weatherPage/domain/entities/weatherEntity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({

    required double minTemperature,
    required double maxTemperature,
    required double precipitation,
  }): super(
    minTemperature: minTemperature,
    maxTemperature: maxTemperature,
    precipitation: precipitation
  );

  factory WeatherModel.fromJson(Map < String, dynamic > json) => WeatherModel(
    minTemperature: json['temperature']['min'],
    maxTemperature: json['temperature']['max'],
    precipitation: json['precipitation']['total'],
  );


 
 WeatherEntity toEntity() => WeatherEntity(
    minTemperature: minTemperature,
    maxTemperature: maxTemperature,
    precipitation: precipitation,
  );
}

