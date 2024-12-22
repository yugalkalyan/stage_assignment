import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../data_models/movies_list_data_model.dart';

part 'hive_state.dart';
part 'hive_events.dart';


class HiveStorageBloc extends Bloc<HiveStorageEvents,HiveStorageState>{
  HiveStorageBloc():super(const HiveStorageState()){
    on<InitialiseHiveStorageEvent>(_initialiseHive);
    on<AddMovieToHiveListEvent>(_addToHive);
  }
  late Box<MovieListResult> movieBox;
   List<MovieListResult> data=[];
  Future<void>_initialiseHive(InitialiseHiveStorageEvent event,Emitter<HiveStorageState>emit)async{
    movieBox = await Hive.openBox<MovieListResult>('movies');
      data=movieBox.values.toList();
    print(data.runtimeType);
    print(data);
    emit(state.copyWith(hiveStorageStatus:HiveStorageStatus.success, movies:data));
  }

  Future<void>_addToHive(AddMovieToHiveListEvent event,Emitter<HiveStorageState>emit)async{
    List<MovieListResult> moviesList=state.movies;
  if(!moviesList.contains(event.movieData)){
    moviesList.add(event.movieData);
    movieBox.add(event.movieData);
  }else{
    int index = moviesList.indexOf(event.movieData);
    if (index != -1) {
      moviesList.removeAt(index);
     await movieBox.deleteAt(index);
    }
  }
    emit(state.copyWith(hiveStorageStatus:HiveStorageStatus.success, movies:moviesList));
  }
}