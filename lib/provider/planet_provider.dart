import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/planet_helper.dart';
import '../model/planet_model.dart';

class PlanetProvider with ChangeNotifier {
  List<PlanetList>? planet;
  List<PlanetList> get bookmarkedPlanets {
    if (planet == null) return [];
    return planet!.where((planet) {
      return bookmarks[planet.name ?? ''] ?? false;
    }).toList();
  }

  void getApi() async {
    ApiHelper helper = ApiHelper();
    planet = await helper.api();
    notifyListeners();
  }

  Map<String, bool> bookmarks = {};

  bool isBookmarked(String planetName) {
    return bookmarks[planetName] ?? false;
  }

  Future<void> toggleBookmark(PlanetList planet) async {
    final prefs = await SharedPreferences.getInstance();
    final planetName = planet.name ?? '';

    bool currentStatus = bookmarks[planetName] ?? false;
    bookmarks[planetName] = !currentStatus;

    await prefs.setBool('bookmark_${planetName}', !currentStatus);
    notifyListeners();
  }

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    for (var key in keys) {
      if (key.startsWith('bookmark_')) {
        bookmarks[key.replaceFirst('bookmark_', '')] =
            prefs.getBool(key) ?? false;
      }
    }
    notifyListeners();
  }
}
