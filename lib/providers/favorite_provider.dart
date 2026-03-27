import 'package:flutter/material.dart';
import '../models/movie.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Movie> _favorites = [];

  List<Movie> get favorites => _favorites;

  bool isFavorite(Movie movie) {
    return _favorites.contains(movie);
  }

  void toggleFavorite(Movie movie) {
    if (_favorites.contains(movie)) {
      _favorites.remove(movie); 
    } else {
      _favorites.add(movie); 
    }
    
    notifyListeners(); 
  }
}