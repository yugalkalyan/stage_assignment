part of 'movies_list_bloc.dart';

enum MoviesListStatus{
  initial,
  loading,
  success,
  failure,
  noInternet
}

class MoviesListState{
  const MoviesListState({this.moviesListStatus=MoviesListStatus.initial,this.moviesList=const<MovieListResult>[]});
  final MoviesListStatus moviesListStatus;
  final List<MovieListResult> moviesList;

  MoviesListState copyWith({
    MoviesListStatus? moviesListStatus,
    List<MovieListResult>? moviesList,
  }){
    return MoviesListState(
      moviesListStatus: moviesListStatus??this.moviesListStatus,
      moviesList: moviesList??this.moviesList
    );
  }
}