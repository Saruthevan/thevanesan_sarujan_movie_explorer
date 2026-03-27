import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';


Future<List<Movie>> fetchMovies() async { 
  final uri = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=95deaeffcf11a7b4c8668257471953b1&language=fr-FR'); 
  final response = await http.get(uri); 

  if (response.statusCode == 200) { 
    final data = jsonDecode(response.body); 
    final List<dynamic> results = data['results']; 
    return results.map((item) => Movie.fromJson(item as Map<String, dynamic>)).toList(); 
  } else {
    throw Exception('Erreur HTTP: ${response.statusCode}'); 
  }
}

Future<List<Movie>> searchMovies(String query) async { 
  if (query.isEmpty) return fetchMovies();

  final String encodedQuery = Uri.encodeQueryComponent(query);

  final uri = Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=95deaeffcf11a7b4c8668257471953b1&language=fr-FR&query=$encodedQuery'); 
  final response = await http.get(uri); 

  if (response.statusCode == 200) { 
    final data = jsonDecode(response.body); 
    final List<dynamic> results = data['results']; 
    return results.map((item) => Movie.fromJson(item as Map<String, dynamic>)).toList(); 
  } else {
    throw Exception('Erreur HTTP: ${response.statusCode}'); 
  }
}

Future<List<Movie>> fetchUpcomingMovies() async { 
  final uri = Uri.parse('https://api.themoviedb.org/3/movie/upcoming?api_key=95deaeffcf11a7b4c8668257471953b1&language=fr-FR'); 
  final response = await http.get(uri); 

  if (response.statusCode == 200) { 
    final data = jsonDecode(response.body); 
    final List<dynamic> results = data['results']; 
    return results.map((item) => Movie.fromJson(item as Map<String, dynamic>)).toList(); 
  } else {
    throw Exception('Erreur HTTP: ${response.statusCode}'); 
  }
}
