import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

class FavoritesProvider extends ChangeNotifier {
  List<String> _favorites = [];
  final LocalStorageService _storage = LocalStorageService();

  List<String> get favorites => _favorites;

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    _favorites = await _storage.getFavorites();
    notifyListeners();
  }

  Future<void> toggleFavorite(String lessonId) async {
    if (_favorites.contains(lessonId)) {
      _favorites.remove(lessonId);
    } else {
      _favorites.add(lessonId);
    }
    await _storage.saveFavorites(_favorites);
    notifyListeners();
  }

  bool isFavorite(String lessonId) {
    return _favorites.contains(lessonId);
  }
}