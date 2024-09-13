import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavPlacesList extends StatefulWidget {
  const FavPlacesList({super.key});

  @override
  State<FavPlacesList> createState() => _FavPlacesListState();
}

class _FavPlacesListState extends State<FavPlacesList> {
  // List<dynamic> FavPlaces = [
  //   {'state': 'Rajsathan', 'city': 'Udaipur'},
  //   {'state': 'Rajasthan', 'city': 'Jaipur'},
  //   {'state': 'Jammu & Kashmir', 'city': 'Srinagar '},
  //   {'state': 'uttar pradesh', 'city': 'Lucknow'}
  // ];
  List<dynamic> FavPlaces2 = [];
  List<dynamic> FavPlaces = Get.arguments;
  @override
  Widget build(BuildContext context) {
    // print("-------------${FavPlaces.isEmpty}");
    // print("-------------$FavPlaces");

    return WillPopScope(
        onWillPop: () async {
          // Return data when the phone's back button is pressed
          Get.back(result: FavPlaces);
          return false; // Prevent default back navigation
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Favourite Places"),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_sharp),
              onPressed: () {
                Get.back(result: FavPlaces);
              },
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  child: FavPlaces.isEmpty
                      ? Center(child: Text("No Places in Favourite"))
                      : ListView.builder(
                          itemCount: FavPlaces.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  FavPlaces2.add(FavPlaces[index]);
                                  FavPlaces.remove(FavPlaces[index]);
                                  setState(() {});
                                },
                                title: Text(
                                  (FavPlaces[index].poi == ""
                                        ? FavPlaces[index].subSubLocality == ""
                                            ? FavPlaces[index].subLocality == ""
                                                ? FavPlaces[index].locality ==""
                                                    ? FavPlaces[index].subDistrict ==""
                                                        ? FavPlaces[index].district ==""
                                                            ? FavPlaces[index].city ==""
                                                            ?FavPlaces[index].state
                                                            : FavPlaces[index].city
                                                        : FavPlaces[index].district
                                                    : FavPlaces[index].subDistrict
                                                : FavPlaces[index].locality
                                            : FavPlaces[index].subLocality
                                        : FavPlaces[index].subSubLocality
                                      :FavPlaces[index].poi
                                  )

                                    .toString()),
                                subtitle: Text(
                                    (FavPlaces[index].formattedAddress)
                                        .toString()),

                                // title: Text(
                                //     (FavPlaces[index]['state']).toString()),
                                // subtitle:
                                //     Text((FavPlaces[index]['city']).toString()),

                                trailing: IconButton(
                                  onPressed: () {
                                    FavPlaces.remove(FavPlaces[index]);
                                    setState(() {});
                                  },
                                  // onPressed: () {
                                  //   FavPlaces.remove(FavPlaces[index]);
                                  //   setState(() {});
                                  // },
                                  icon: Icon(Icons.remove), color: Colors.red,
                                  iconSize: 30.0,
                                ),
                              ),
                            );
                          }),
                ),
              ),
              Text(
                "Draggable List",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Expanded(
                child: Container(
                  child: FavPlaces2.isEmpty
                      ? Center(child: Text("Add Places"))
                      : ReorderableListView.builder(
                          onReorder: (oldIndex, newIndex) {
                            if (oldIndex < newIndex) {
                              newIndex--;
                            }
                            var card = FavPlaces2.removeAt(oldIndex);
                            FavPlaces2.insert(newIndex, card);
                          },
                          itemCount: FavPlaces2.length,
                          itemBuilder: (context, index) {
                            return Card(
                              key: ValueKey(index),
                              child: ListTile(
                                onTap: () {
                                  FavPlaces.add(FavPlaces2[index]);
                                  if (FavPlaces2.length == 1) {
                                    FavPlaces2 = [];
                                  } else {
                                    FavPlaces2.remove(FavPlaces2[index]);
                                  }
                                  setState(() {});
                                },
                                // title: Text((FavPlaces[index].state).toString()),
                                // subtitle: Text((FavPlaces[index].city).toString()),
                                title: Text(
                                  (FavPlaces2[index].poi == ""
                                        ? FavPlaces2[index].subSubLocality == ""
                                            ? FavPlaces2[index].subLocality == ""
                                                ? FavPlaces2[index].locality ==""
                                                    ? FavPlaces2[index].subDistrict ==""
                                                        ? FavPlaces2[index].district ==""
                                                            ? FavPlaces2[index].city ==""
                                                            ?FavPlaces2[index].state
                                                            : FavPlaces2[index].city
                                                        : FavPlaces2[index].district
                                                    : FavPlaces2[index].subDistrict
                                                : FavPlaces2[index].locality
                                            : FavPlaces2[index].subLocality
                                        : FavPlaces2[index].subSubLocality
                                      :FavPlaces2[index].poi
                                  )

                                    .toString()),
                                subtitle: Text(
                                    (FavPlaces2[index].formattedAddress)
                                        .toString()),
                              ),
                            );
                          }),
                ),
              )
            ],
          ),
        ));
  }
}
