import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mapple/FavPlaces.dart';
import 'package:mapple/Getx_Controllers.dart';
import 'package:mapple/access_toke.dart';
import 'package:mapple/search_suggestion.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import 'package:mapple/search_suggestion_model.dart';

void main() {
  runApp(const GetMaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MapmyIndiaMapController mapController;
  dynamic token;
  late OverlayEntry overlayEntry;
  List<dynamic> FavPlaces = Get.arguments ?? [];

  searchoverlay(List<dynamic>? data, BuildContext context) {
    OverlayState overlaystate = Overlay.of(context);
    try {
      overlayEntry.remove();
    } catch (e) {
      debugPrint(e.toString());
    }
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        top: 70,
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount: data!.length,
            itemBuilder: (context, index) {
              // debugPrint(data[index].);
              return Container(
                color: Colors.white,
                child: Card(
                  child: ListTile(
                    title: Text((data[index].poi == ""
                            ? data[index].subSubLocality == ""
                                ? data[index].subLocality == ""
                                    ? data[index].locality == ""
                                        ? data[index].subDistrict == ""
                                            ? data[index].district == ""
                                                ? data[index].city == ""
                                                    ? data[index].state
                                                    : data[index].city
                                                : data[index].district
                                            : data[index].subDistrict
                                        : data[index].locality
                                    : data[index].subLocality
                                : data[index].subSubLocality
                            : data[index].poi)
                        .toString()),
                    subtitle: Text((data[index].formattedAddress).toString()),
                    //subtitleTextStyle: TextStyle(),
                    trailing: IconButton(
                        onPressed: () {
                          FavPlaces.add(data[index]);
                          Get.snackbar("Added",
                              "Loacation Added to Favourite Places List");
                        },
                        icon: Icon(Icons.add)),
                  ),
                ),
              );
            }),
      );
    });
    overlaystate.insert(overlayEntry);
  }

  gettoken() async {
    AccessToken object = AccessToken();
    token = await object.response;
    print(token);
  }

  apicall(token, String place) async {
    List<dynamic> data = [];
    SearchSuggestion search = SearchSuggestion(token, place);
    var response_data = await search.response;

    //print(response_data);
    // data = (response_data['copResults'] as List)
    //     .map((result) => CopResult.fromJson(result))
    //     .toList();

    data = response_data['copResults'];
    var cop = data.map<CopResult>((json) => CopResult.fromJson(json)).toList();
    return cop;
  }

  // Declare the mapController variable
  @override
  void initState() {
    super.initState();
    
    MapmyIndiaAccountManager.setMapSDKKey("");
    MapmyIndiaAccountManager.setRestAPIKey("");
    MapmyIndiaAccountManager.setAtlasClientId(
        "");
    MapmyIndiaAccountManager.setAtlasClientSecret(
        "");
    gettoken();
  }

  @override
  Widget build(BuildContext context) {
    SearchBarController searchController = Get.put(SearchBarController());
    print("Building..............");
    return Scaffold(
      body: Stack(
        children: [
          MapmyIndiaMap(
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(25.321684, 82.987289), // Initial map position
              zoom: 14.0,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Container(
                // decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.5),borderRadius: BorderRadius.circular(30)),
                height: 55,
                child: TextField(
                  onTapOutside: (value) {},
                  controller: searchController.text.value,
                  decoration: InputDecoration(
                    hintText: 'Search for a location',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30)),
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) async {
                    if (value != "") {
                      List<dynamic> data = await apicall(token, value);
                      searchoverlay(data, context);
                    } else {
                      overlayEntry.remove();
                    }
                  },
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 10,
              right: 10,
              child: IconButton(
                  onPressed: () async {
                    try {
                      overlayEntry.remove();
                    } catch (e) {}
                    FavPlaces = await Get.to(() => FavPlacesList(),
                        arguments: FavPlaces);
                    print("----------------------------${FavPlaces}");
                  },
                  icon: Icon(Icons.favorite),
                  iconSize: 50.0,
                  color: Colors.red))
        ],
      ),
    );
  }
}
