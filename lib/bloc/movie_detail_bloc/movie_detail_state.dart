part of 'movie_detail_bloc.dart';

enum MovieDetailStatus{
  initial,
  loading,
  success,
  failure,
}

class MovieDetailState{
  const MovieDetailState({this.movieDetailStatus=MovieDetailStatus.initial,this.movieDetailDataModel});
  final MovieDetailStatus movieDetailStatus;
  final MovieDetailDataModel?movieDetailDataModel;

  MovieDetailState copyWith({
    MovieDetailStatus? movieDetailStatus,
    MovieDetailDataModel?movieDetailDataModel
  }){
    return MovieDetailState(
      movieDetailStatus: movieDetailStatus??this.movieDetailStatus,
      movieDetailDataModel: movieDetailDataModel??this.movieDetailDataModel
    );
  }
}