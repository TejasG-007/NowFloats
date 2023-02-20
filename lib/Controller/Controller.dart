import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/Weather.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;

  final WeatherService _weatherService = WeatherService();

  Weather? _currentWeather;

  Weather? get weather => _weather;
  Weather? get currentWeather =>_currentWeather;
  bool _isLoading = false;

  get isLoading=>_isLoading;

  List<Weather?> _favouriteList = [];

  get getFav=>_favouriteList;

  get favLength=>_favouriteList.length;

   bool setFav(Weather? data){
   for(Weather? check in _favouriteList){
     if((data!.cityName==check!.cityName)){
       return false;
     }
   }
     _favouriteList.add(data);
     notifyListeners();
     return true;


  }

  remFav(Weather? data){
    _favouriteList.removeWhere((e)=>e?.cityName==data?.cityName);
    notifyListeners();
    return true;
  }

  clearList(){
     _favouriteList.clear();
     notifyListeners();
  }
  bool checker(String name){
     Iterable<bool> itr = _favouriteList.map((e) => e?.cityName==name?true:false);
     return itr.contains(true)? true: false;
  }

  fetchCurrentLocationWeatherData()async{
    _isLoading = true;
    notifyListeners();
    try{
      LocationPermission _permission =await Geolocator.checkPermission();
      if(_permission==LocationPermission.denied){
       _permission = await Geolocator.requestPermission();
       if(_permission==LocationPermission.denied){
         return;
       }
      }
      final location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _currentWeather = await _weatherService.getWeatherForCurrentLocation(location.latitude, location.longitude);

    }catch(e){
      throw Exception("Error while fetching current location$e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getWeatherData(String cityName) async {
    _weather = await _weatherService.getWeatherForCity(cityName);
    notifyListeners();
  }

  Future<void> removeFromSavedList()async{
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove("fav");
      List<String> tosaveList = [];
      for(Weather? data in _favouriteList){
        Map<String,dynamic> map = {
          "cityName":data!.cityName,
          "temperature":data!.temperature.toString(),
          "description":data!.description,
        };
        final String jData = jsonEncode(map);
        tosaveList.add(jData.toString());
      }
      await pref.setStringList("fav", tosaveList);
    }catch(e){
      throw Exception("Unable to Save data$e");
    }
  }

  Future<void> savedFavList()async{
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String> tosaveList = [];
      for(Weather? data in _favouriteList){
        Map<String,dynamic> map = {
          "cityName":data!.cityName,
          "temperature":data!.temperature.toString(),
          "description":data!.description,
        };
        final String jData = jsonEncode(map);
        tosaveList.add(jData.toString());
      }
      await pref.setStringList("fav", tosaveList);
    }catch(e){
      throw Exception("Unable to Save data$e");
    }
  }

  Future<void> getSavedFavList()async{
    try{

      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? jData =  pref.getStringList("fav");
      jData?.toSet().toList();
      for(String data in jData!){
        Map<String,dynamic> rawtoJ = jsonDecode(data);
        Weather obj = Weather(cityName: rawtoJ["cityName"], temperature: double.parse(rawtoJ["temperature"]), description: rawtoJ["description"]);
        setFav(obj);
      }
    }catch(e){
      throw Exception("Unable to fetch data $e");
    }

  }



}