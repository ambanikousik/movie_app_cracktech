import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_cracktech/domain/movie.dart';

class MovieListTile extends StatelessWidget {
  final Movie movie;
  const MovieListTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: movie.posterUrl,
          height: 100,
          width: 100,
        ),
      ],
    );
  }
}
