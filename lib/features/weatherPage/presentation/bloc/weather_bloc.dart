import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/presentation/bloc/weather_event.dart';
import 'package:weather/features/presentation/bloc/weather_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather/features/weatherPage/domain/usecases/get_weather.dart';


class WeatherBloc extends Bloc<WeatherEvent,WeatherState> {
  
  final GetWeatherUseCase _getWeatherUseCase;
  WeatherBloc(this._getWeatherUseCase) : super(WeatherEmpty()) {
    on<OnPosition>(
      (event, emit) async {

        emit(WeatherLoading());
        final result = await _getWeatherUseCase.execute(event.latitude,event.longitude,event.date);
        result.fold(
          (failure) {
            emit(WeatherLoadFailue(failure.message));
          },
          (data) {
            emit(WeatherLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }