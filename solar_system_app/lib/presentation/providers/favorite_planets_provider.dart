import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePlanetsProvider extends ChangeNotifier {
  List<String> _favoritePlanets = [];

  List<String> get favoritePlanets => _favoritePlanets;

  FavoritePlanetsProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favoritePlanets = prefs.getStringList('favorite_planets') ?? [];
    notifyListeners();
  }

  Future<void> toggleFavorite(String planetName) async {
    final prefs = await SharedPreferences.getInstance();
    if (_favoritePlanets.contains(planetName)) {
      _favoritePlanets.remove(planetName);
    } else {
      _favoritePlanets.add(planetName);
    }
    await prefs.setStringList('favorite_planets', _favoritePlanets);
    notifyListeners();
  }
}