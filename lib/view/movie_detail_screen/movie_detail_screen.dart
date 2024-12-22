import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stage_assignment/bloc/movie_detail_bloc/movie_detail_bloc.dart';

import '../../constants/urls.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key,required this.movieId});
  final int movieId;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    context.read<MovieDetailBloc>().add(FetchMovieDetailEvent(movieId: widget.movieId));
    super.initState();
  }
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: BlocBuilder<MovieDetailBloc,MovieDetailState>(builder: (context,state){
          switch(state.movieDetailStatus){
            case MovieDetailStatus.initial:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case MovieDetailStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case MovieDetailStatus.success:
              var data= state.movieDetailDataModel;
          return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                SizedBox(
                   height: 330,
                   width: MediaQuery.of(context).size.width,
                   child: Stack(
                     children: [
                       SizedBox(
                         height: 200,
                         width: MediaQuery.of(context).size.width,
                         child: CachedNetworkImage(
                           imageUrl: "$imageBaseUrl${data!.backdropPath}",
                           fit: BoxFit.fill,
                         ),
                       ),
                        Padding(
                         padding:const EdgeInsets.all(16.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             InkWell(
                               onTap: (){
                                 Navigator.pop(context);
                               },
                                 child: const Icon(Icons.arrow_back,color: Colors.white,)),
                            const Icon(Icons.share,color: Colors.white,),
                           ],
                         ),
                       ),
                       Positioned(
                         top: 180,
                         left: 20,
                         child: SizedBox(
                           height: 150,
                           width: MediaQuery.of(context).size.width,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                         Row(
                           children: [
                             CachedNetworkImage(
                               imageUrl: "$imageBaseUrl${data.posterPath}",
                               width: 100,
                               height: 150,
                               fit: BoxFit.cover,
                             ),
                             Padding(
                               padding: const EdgeInsets.fromLTRB(16,30,16,16),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   SizedBox(
                                     width: MediaQuery.of(context).size.width*0.45,
                                       child: Text(data.originalTitle,maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                   Text('Average rating: ${data.voteAverage}'),
                                 ],
                               ),
                             ),
                           ],
                         ),
                               IconButton(
                                 padding: const EdgeInsets.fromLTRB(16,30,25,16),
                                 icon: const Icon(Icons.favorite),
                                 onPressed: () {},
                               ),
                             ],
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
                 const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                    child: Text(data.overview,
                    ),
                  ),
                 const  Divider(height: 32),
                ],
              ),
            ),
          ],
        );
            case MovieDetailStatus.failure:
              return const Text("Somthing went wrong");
          }
        })

      );
    }
}


