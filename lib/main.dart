import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stage_assignment/bloc/hive_bloc/hive_bloc.dart';
import 'package:stage_assignment/bloc/movies_list_bloc/movies_list_bloc.dart';
import 'package:stage_assignment/view/movie_list_screen/movie_list_screen.dart';

import 'bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'data_models/movies_list_data_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final path = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationSupportDirectory();
  Hive..init(path!.path)
  ..registerAdapter(MovieListResultAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HiveStorageBloc>(create: (_) => HiveStorageBloc()..add(const InitialiseHiveStorageEvent(),),lazy: false,),
        BlocProvider<MoviesListBloc>(create: (_) => MoviesListBloc()..add(const FetchMoviesListEvent())),
        BlocProvider<MovieDetailBloc>(create: (_) => MovieDetailBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MovieListScreen(),
      ),
    );
  }
}


