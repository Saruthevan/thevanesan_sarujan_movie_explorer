import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/api.dart';
import 'detail_screen.dart';
import '../widgets/movie_image.dart'; 

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Movie> searchResults = [];
  bool isLoading = false;
  String? errorMessage;
  bool hasSearched = false;

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
        hasSearched = false;
        errorMessage = null;
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
      hasSearched = true;
    });

    try {
      final results = await searchMovies(query);
      setState(() {
        searchResults = results;
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
        title: const Text('Recherche'),
        foregroundColor: const Color.fromARGB(255, 209, 0, 0),
        backgroundColor: const Color.fromARGB(255, 47, 47, 49),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Rechercher un film...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.black26,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (value) {
                _performSearch(value);
              },
            ),
          ),
          
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: _buildSearchResults(), 
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildSearchResults() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.red));
    }
    if (errorMessage != null) {
      return Center(child: Text(errorMessage!, style: const TextStyle(color: Colors.white)));
    }
    
    if (!hasSearched) {
      return const Center(child: Text("Tapez un titre pour lancer la recherche.", style: TextStyle(color: Colors.grey)));
    }

    if (searchResults.isEmpty) {
      return const Center(child: Text("Aucun film trouvé.", style: TextStyle(color: Colors.white)));
    }

    return ListView.separated(
      itemCount: searchResults.length,
      separatorBuilder: (context, index) => const Divider(color: Colors.grey), 
      itemBuilder: (context, index) {
        final movie = searchResults[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(movie: movie),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: MovieImage( 
                    posterPath: movie.posterPath, 
                    width: 80,
                    height: 120,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title, 
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.overview,
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}