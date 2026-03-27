import 'package:flutter/material.dart';

class MovieImage extends StatelessWidget {
  final String? posterPath;
  final double height;
  final double width;

  const MovieImage({
    super.key, 
    required this.posterPath, 
    this.height = double.infinity, 
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    if (posterPath == null || posterPath!.isEmpty) {

      return Container(
        height: height,
        width: width,
        color: Colors.grey[800],
        child: const Icon(Icons.movie, color: Colors.grey),
      );
    }


    final String imageUrl = 'https://image.tmdb.org/t/p/w500$posterPath';
    return Image.network(
      imageUrl,
      height: height,
      width: width,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: height,
          width: width,
          color: Colors.grey[800],
          child: const Icon(Icons.broken_image, color: Colors.redAccent),
        );
      },
    );
  }
}