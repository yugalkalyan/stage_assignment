part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent{
  const MovieDetailEvent();
}

class FetchMovieDetailEvent extends MovieDetailEvent{
  const FetchMovieDetailEvent({required this.movieId});
  final int movieId;
}