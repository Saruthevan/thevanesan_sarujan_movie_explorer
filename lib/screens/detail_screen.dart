import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../widgets/movie_image.dart';
import '../providers/favorite_provider.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;

  const DetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.watch<FavoriteProvider>();
    final bool isFav = favoriteProvider.isFavorite(movie);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 47, 47, 49),
      appBar: AppBar(
        title: Text(movie.title),
        foregroundColor: const Color.fromARGB(255, 63, 60, 60),
        backgroundColor: const Color.fromARGB(255, 47, 47, 49),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: MovieImage(
                posterPath: movie.posterPath,
                height: 350,
                width: 230,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                movie.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                movie.overview,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                context.read<FavoriteProvider>().toggleFavorite(movie);
              },
              icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
              label: Text(
                isFav ? "Retirer des favoris" : "Ajouter aux favoris",
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                backgroundColor: const Color.fromARGB(255, 255, 0, 106),
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
