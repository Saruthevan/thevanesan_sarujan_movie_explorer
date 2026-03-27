import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/api.dart';
import 'detail_screen.dart';
import 'search_screen.dart'; 
import 'favorites_screen.dart';
import '../widgets/movie_image.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  List<Movie> popularMovies = [];
  List<Movie> upcomingMovies = [];
  
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final results = await Future.wait([
        fetchMovies(),
        fetchUpcomingMovies(),
      ]);

      setState(() {
        popularMovies = results[0]; 
        upcomingMovies = results[1]; 
        isLoading = false; 
      });
    } catch (e) {
      setState(() {
        errorMessage = "Impossible de charger les films : $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 47, 47, 49),
      appBar: AppBar(
        title: const Text('Movie Explorer',
        style:  TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,),
        ),
        centerTitle: true, 
        foregroundColor: const Color.fromARGB(255, 209, 0, 0),
        backgroundColor: const Color.fromARGB(255, 47, 47, 49),
        elevation: 0,
      ),
      body: _buildBody(),
      
      
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          FloatingActionButton(
            heroTag: "searchBtn", 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            backgroundColor: const Color.fromARGB(255, 209, 0, 0),
            child: const Icon(Icons.search, color: Colors.white),
          ),
          
          const SizedBox(width: 16), 
          
          FloatingActionButton(
            heroTag: "favBtn", 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              );
            },
            backgroundColor: const Color.fromARGB(255, 209, 0, 0),
            child: const Icon(Icons.favorite, color: Colors.white),
          ),
        ],
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.red));
    }
    if (errorMessage != null) {
      return Center(child: Text(errorMessage!, style: const TextStyle(color: Colors.white)));
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _buildSectionTitle('Films Populaires'),
          _buildCarousel(popularMovies),
          
          const SizedBox(height: 20),
          
          _buildSectionTitle('Prochainement au cinéma'),
          _buildCarousel(upcomingMovies),
          
          const SizedBox(height: 80), 
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCarousel(List<Movie> movieList) {
    if (movieList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("Aucun film trouvé.", style: TextStyle(color: Colors.grey)),
      );
    }

    return SizedBox(
      height: 280, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal, 
        itemCount: movieList.length, 
        itemBuilder: (context, index) {
          final movie = movieList[index];
          
          return InkWell( 
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(movie: movie),
                ),
              );
            },
            child: Container(
              width: 140, 
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      
                      child: MovieImage(
                        posterPath: movie.posterPath,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}