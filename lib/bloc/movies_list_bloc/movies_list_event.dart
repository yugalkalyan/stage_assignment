part of 'movies_list_bloc.dart';

abstract class MoviesListEvent{
  const MoviesListEvent();
}

class FetchMoviesListEvent extends MoviesListEvent{
  const FetchMoviesListEvent({this.pageIndex=1});
  final int pageIndex;
}