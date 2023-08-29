class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/3.0/onecall';
  static const String apiKey = '5b15ebe53f355b372c73ee64c8b3a722';
  static String weatherByPosition(String latitude,String longitude,String date) =>
      '$baseUrl/day_summary?lat=$latitude&lon=$longitude&date=$date&tz=+03:00&appid=$apiKey';
  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}