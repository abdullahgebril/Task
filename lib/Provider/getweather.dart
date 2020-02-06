



import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
const APIKEY = 'fdc83e178241cc4a6b04048717ac56c8';
class getWeather with ChangeNotifier{

  Future getweather(String cityName)async{
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName,uk&appid=$APIKEY';
    var tem;
    try{
      http.Response response = await http.get(url);
      final weatherMap = jsonDecode(response.body) as Map<String,dynamic>;

      return weatherMap;

    }catch(e){
      throw e;
    }


  }
}