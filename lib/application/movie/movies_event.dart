import 'package:equatable/equatable.dart';

class LoadMoviesEvent extends Equatable {
  final String genre;
  const LoadMoviesEvent({
    required this.genre,
  });

  @override
  List<Object> get props => [genre];

  @override
  String toString() => 'LoadDataEvent(genre: $genre)';
}
