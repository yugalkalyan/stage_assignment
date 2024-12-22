part of 'hive_bloc.dart';

abstract class HiveStorageEvents{
  const HiveStorageEvents();
}

class InitialiseHiveStorageEvent extends HiveStorageEvents{
  const InitialiseHiveStorageEvent();
}

class AddMovieToHiveListEvent extends HiveStorageEvents{
  const AddMovieToHiveListEvent({required this.movieData});
final MovieListResult movieData;
}