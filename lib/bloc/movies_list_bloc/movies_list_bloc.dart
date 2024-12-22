import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stage_assignment/constants/string_utils.dart';
import 'package:stage_assignment/constants/urls.dart';
import 'package:stage_assignment/data_models/movies_list_data_model.dart';

import '../../util_function/error_toast.dart';

part 'movies_list_event.dart';
part 'movies_list_state.dart';


class MoviesListBloc extends Bloc<MoviesListEvent,MoviesListState>{
  MoviesListBloc():super(const MoviesListState()){
    on<FetchMoviesListEvent>(_fetchMoviesList);
  }

  Future<void>_fetchMoviesList(FetchMoviesListEvent event,Emitter<MoviesListState>emit)async{
    try {
      String url = "$moviesListUrl${event.pageIndex}";
      var header = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $tMDBAuthKey",
      };
      final response = await http.get(
          Uri.parse(url), headers: header,);
      const utf8decoder = Utf8Decoder();
      final decodedContent = utf8decoder.convert(response.bodyBytes);
      if (response.statusCode == 200) {
        MoviesListDataModel data=moviesListDataModelFromJson(decodedContent);
        emit(state.copyWith(moviesListStatus:MoviesListStatus.success, moviesList:data.results));
      } else if (response.statusCode == 400) {
        emit(state.copyWith(moviesListStatus:MoviesListStatus.failure, moviesList:[]));
        errorMessage();
      }else if (response.statusCode == 401) {
        emit(state.copyWith(moviesListStatus:MoviesListStatus.failure, moviesList:[]));
        errorMessage(message: "Session Expired");
      } else if (response.statusCode == 500) {
        emit(state.copyWith(moviesListStatus:MoviesListStatus.failure, moviesList:[]));
        errorMessage(message: "Server Error");
      }
    } on SocketException catch (e) {
      switch (e.osError?.errorCode) {
        case 7:
          emit(state.copyWith(moviesListStatus:MoviesListStatus.noInternet, moviesList:[]));
          errorMessage(message: "No internet connection!");
          break;
        case 111:
          emit(state.copyWith(moviesListStatus:MoviesListStatus.failure, moviesList:[]));
          errorMessage(message: "Unable To Connect To Server!");
          break;
      }
    } on TimeoutException catch (e) {
      errorMessage(message: "TimeoutException");
      emit(state.copyWith(moviesListStatus:MoviesListStatus.failure, moviesList:[]));
    } catch (err, s) {
      errorMessage(message: "Error While Making network call");
      emit(state.copyWith(moviesListStatus:MoviesListStatus.failure, moviesList:[]));
    }
  }
}