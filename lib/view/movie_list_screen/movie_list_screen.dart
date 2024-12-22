import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stage_assignment/bloc/hive_bloc/hive_bloc.dart';
import 'package:stage_assignment/bloc/movies_list_bloc/movies_list_bloc.dart';
import 'package:stage_assignment/constants/urls.dart';
import 'package:stage_assignment/view/movie_detail_screen/movie_detail_screen.dart';

import '../../data_models/movies_list_data_model.dart';
part 'movie_card.dart';
part 'favourite_movie_list.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text("Movie List"),
  leading: Icon(Icons.menu),
  actions: [IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))],
),
      body: BlocConsumer<MoviesListBloc,MoviesListState>(
        listenWhen:(previous,current)=>previous.moviesListStatus!=current.moviesListStatus,
        listener:(context,state){
          if(state.moviesListStatus==MoviesListStatus.noInternet){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const FavouriteListScreen()));
          }
        } ,
        buildWhen: (previous,current)=>previous.moviesListStatus!=current.moviesListStatus,
          builder: (context,state){
        switch(state.moviesListStatus){

          case MoviesListStatus.initial:
         return Center(
           child: CircularProgressIndicator(),
         );
          case MoviesListStatus.loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          case MoviesListStatus.success:
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: GridView.builder(gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3.0,
              mainAxisSpacing: 3.0,
              childAspectRatio: 1.1 / 2,),
                itemCount: state.moviesList.length,
                itemBuilder: (context,index){
                  return MovieListCard(cardDetails: state.moviesList[index],);
                }),
          );
          case MoviesListStatus.failure:
          return const Center(child: Text("Somthing went wrong"));
          case MoviesListStatus.noInternet:
            return const SizedBox.shrink();
        }

      })
    );
  }
}
