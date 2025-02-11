// import 'dart:convert';
//
// import 'package:flutter/services.dart';
// import 'package:planet/model/planet_model.dart';
//
// class ApiHelper {
//   Future<PlanetModel?> api() async {
//     String json =
//         await rootBundle.loadString("lib/utils/planet_api/planet_json.json");
//     Map<String, dynamic> jsonMap = jsonDecode(json);
//     return PlanetModel.maptomodel(jsonMap);
//   }
// }
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:planet/model/planet_model.dart';

class ApiHelper {
  Future<List<PlanetList>?> api() async {
    try {
      String json =
          await rootBundle.loadString("lib/utils/planet_api/planet_json.json");

      List jsonList = jsonDecode(json);
      print(jsonList);

      List<PlanetList> planetList =
          jsonList.map((e) => PlanetList.maptomodel(e)).toList();
      print(
          "werty======================================================================================${planetList}");
      return planetList;
    } catch (e) {
      print("Error loading or parsing JSON: $e");
      return null;
    }
  }
}
