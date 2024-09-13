import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchSuggestion {
  late Future<dynamic> response;
  final JsonDecoder d = const JsonDecoder();

  SearchSuggestion(String accessToken, String place) {
    response = getdata(accessToken, place).then((value) {
      return value;
    });
  }

  Future<dynamic> getdata(accessToken, place) async {
    http.Response request = await http.get(
        Uri.parse(
            "https://atlas.mappls.com/api/places/geocode?bias=1&address=$place&itemCount=5&bound=2Z3484"),
        headers: {
          "Authorization": "Bearer $accessToken",
          "accept": "application/json",
        });
    print("----------------${jsonDecode(request.body)}");
    //while making a request to https://atlas.mappls.com/api/places/geocode?bias=1&address=$place&itemCount=5 in address a space is incidated with %20
    //udaipur city bound 2Z3484
    //rajasthan bound CW3IVF
    return d.convert(request.body);
  }
}
