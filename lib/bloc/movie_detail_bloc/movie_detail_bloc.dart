import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/string_utils.dart';
import '../../constants/urls.dart';
import 'package:http/http.dart' as http;

import '../../data_models/movie_detail_data_model.dart';
import '../../util_function/error_toast.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';
class MovieDetailBloc extends Bloc<MovieDetailEvent,MovieDetailState>{
  MovieDetailBloc():super(const MovieDetailState()){
    on<FetchMovieDetailEvent>(_fetchMovieDetail);
  }

  Future<void>_fetchMovieDetail(FetchMovieDetailEvent event,Emitter<MovieDetailState>emit)async{
    if(state.movieDetailStatus!=MovieDetailStatus.initial&&state.movieDetailStatus!=MovieDetailStatus.loading){
      emit(state.copyWith(movieDetailStatus: MovieDetailStatus.initial));
    }
    try {
      String url = "$movieDetailsUrl${event.movieId}";
      var header = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $tMDBAuthKey",
      };
      final response = await http.get(
        Uri.parse(url), headers: header,);
      const utf8decoder = Utf8Decoder();
      final decodedContent = utf8decoder.convert(response.bodyBytes);
      if (response.statusCode == 200) {
        MovieDetailDataModel data=movieDetailDataModelFromJson(decodedContent);
        emit(state.copyWith(movieDetailStatus:MovieDetailStatus.success,movieDetailDataModel: data));
      } else if (response.statusCode == 400) {
        emit(state.copyWith(movieDetailStatus:MovieDetailStatus.failure));
        errorMessage();
      }else if (response.statusCode == 401) {
        emit(state.copyWith(movieDetailStatus:MovieDetailStatus.failure));
        errorMessage(message: "Session Expired");
      } else if (response.statusCode == 500) {
        emit(state.copyWith(movieDetailStatus:MovieDetailStatus.failure));
        errorMessage(message: "Server Error");
      }
    } on SocketException catch (e) {
      switch (e.osError?.errorCode) {
        case 7:
          errorMessage(message: "No internet connection!");
          emit(state.copyWith(movieDetailStatus:MovieDetailStatus.failure));
          break;
        case 111:
          errorMessage(message: "Unable To Connect To Server!");
          emit(state.copyWith(movieDetailStatus:MovieDetailStatus.failure));
          break;
      }
    } on TimeoutException catch (e) {
      errorMessage(message: "TimeoutException");
      emit(state.copyWith(movieDetailStatus:MovieDetailStatus.failure));
    } catch (err, s) {
      errorMessage(message: "Error While Making network call");
      emit(state.copyWith(movieDetailStatus:MovieDetailStatus.failure));
    }
  }
}