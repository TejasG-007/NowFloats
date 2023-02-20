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

   setFav(Weather? data){
    _favouriteList.add(data);
    savedFavList();
    getsavedFavList();
    notifyListeners();

  }

  remFav(Weather? data){
    _favouriteList.removeWhere((e)=>e?.cityName==data?.cityName);
    notifyListeners();
  }

  bool checker(String name){
     Iterable<bool> itr = _favouriteList.map((e) => e?.cityName==name?true:false);
     notifyListeners();
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



  Future<void> savedFavList()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<Map<String,dynamic>> JsonData = _favouriteList.map((e) => {"cityName":e!.cityName,"description":e!.description,"temperature":e!.temperature}).toList();
    await pref.setString("fav", JsonData.toString());
    notifyListeners();
  }

  Future<void> getsavedFavList()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
   var data = await pref.getString("fav");
   final re = RegExp(r"/[^,]+,[^,]+,[^,]+/g");
   print("${re.allMatches(data!)} here is the matchers");
   var ss = data?.split(r"/[^,]+,[^,]+,[^,]+/g");
    print("saved list${data}\n${ss}");
    notifyListeners();
  }



}