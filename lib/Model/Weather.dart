import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather {
  final String cityName;
  final double temperature;
  final String description;

  Weather({required this.cityName, required this.temperature, required this.description});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }
}


class WeatherService {
  final String apiKey = 'f397e0446680c1c4e3e640bae3e91229';

  Future<Weather> getWeatherForCity(String cityName) async {
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return Weather.fromJson(result);
    } else {
      throw Exception('Failed to load weather data');
    }
  }


  Future<Weather> getWeatherForCurrentLocation(double lat,double lon) async {
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return Weather.fromJson(result);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

}