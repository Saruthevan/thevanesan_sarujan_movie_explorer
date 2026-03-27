import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'screens/movie_list_screen.dart';
import 'providers/favorite_provider.dart'; 

void main() {
  runApp(
    
    ChangeNotifierProvider(
      create: (context) => FavoriteProvider(), 
      child: const MyApp(), 
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Movie Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 0, 106)),
      ),
      home: const MovieListScreen(), 
    );
  }
}