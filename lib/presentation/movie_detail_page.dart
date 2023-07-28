import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_cracktech/domain/movie.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;
  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: DraggableScrollableSheet(
          expand: false,
          minChildSize: 0.5,
          builder: (context, controller) => ListView(
                padding: const EdgeInsets.all(10),
                controller: controller,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                      spacing: 4,
                      children: movie.genres
                          .map((e) => Chip(
                                label: Text(e),
                                shape: const StadiumBorder(),
                              ))
                          .toList()),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      movie.title,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Year: ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                      children: [
                        TextSpan(
                          text: movie.year,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Director:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(movie.director),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Actors:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(movie.actors),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Plot:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(movie.plot),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Duration:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text('${movie.runtime} min'),
                ],
              )),
      body: SafeArea(
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 0.9,
              child: CachedNetworkImage(
                imageUrl: movie.posterUrl,
                alignment: Alignment.bottomCenter,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: CircleAvatar(
                backgroundColor: Colors.blueGrey.shade700,
                foregroundColor: Colors.white,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
