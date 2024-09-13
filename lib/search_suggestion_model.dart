class SearchSuggestionModel {
  final List<CopResult> copResults;

  SearchSuggestionModel({required this.copResults});

  factory SearchSuggestionModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> copResultsList = json['copResults'];
    final List<CopResult> copResults = copResultsList
        .map((result) => CopResult.fromJson(result))
        .toList();

    return SearchSuggestionModel(copResults: copResults);
  }
}

class CopResult {
  final String houseNumber;
  final String houseName;
  final String poi;
  final String street;
  final String subSubLocality;
  final String subLocality;
  final String locality;
  final String village;
  final String subDistrict;
  final String district;
  final String city;
  final String state;
  final String pincode;
  final String formattedAddress;
  final String eLoc;
  final String geocodeLevel;
  final double confidenceScore;

  CopResult({
    required this.houseNumber,
    required this.houseName,
    required this.poi,
    required this.street,
    required this.subSubLocality,
    required this.subLocality,
    required this.locality,
    required this.village,
    required this.subDistrict,
    required this.district,
    required this.city,
    required this.state,
    required this.pincode,
    required this.formattedAddress,
    required this.eLoc,
    required this.geocodeLevel,
    required this.confidenceScore,
  });

  factory CopResult.fromJson(Map<String, dynamic> json) {
    return CopResult(
      houseNumber: json['houseNumber'] ?? "",
      houseName: json['houseName'] ?? "",
      poi: json['poi'] ?? "",
      street: json['street'] ?? "",
      subSubLocality: json['subSubLocality'] ?? "",
      subLocality: json['subLocality'] ?? "",
      locality: json['locality'] ?? "",
      village: json['village'] ?? "",
      subDistrict: json['subDistrict'] ?? "",
      district: json['district'] ?? "",
      city: json['city'] ?? "",
      state: json['state'] ?? "",
      pincode: json['pincode'] ?? "",
      formattedAddress: json['formattedAddress'] ?? "",
      eLoc: json['eLoc'] ?? "",
      geocodeLevel: json['geocodeLevel'] ?? "",
      confidenceScore: json['confidenceScore'] != null
          ? double.parse(json['confidenceScore'].toString())
          : 0.0,
    );
  }
}
