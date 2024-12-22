part of 'hive_bloc.dart';

enum HiveStorageStatus{
  initial,
  loading,
  success,
  failure,
}

class HiveStorageState{
  const HiveStorageState({this.hiveStorageStatus=HiveStorageStatus.initial,this.movies=const<MovieListResult>[]});
  final HiveStorageStatus hiveStorageStatus;
  final List<MovieListResult> movies;

  HiveStorageState copyWith(
  {HiveStorageStatus? hiveStorageStatus,
    List<MovieListResult>? movies}
  ){
    return HiveStorageState(
      hiveStorageStatus: hiveStorageStatus??this.hiveStorageStatus,
      movies: movies??this.movies
    );
  }

}