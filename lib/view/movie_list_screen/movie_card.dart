part of 'movie_list_screen.dart';

class MovieListCard extends StatefulWidget {
  const MovieListCard({super.key,required this.cardDetails});
final MovieListResult cardDetails;
  @override
  State<MovieListCard> createState() => _MovieListCardState();
}

class _MovieListCardState extends State<MovieListCard> {
 late final MovieListResult cardDetails;
  @override
  void initState() {
    cardDetails=widget.cardDetails;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HiveStorageBloc,HiveStorageState>(builder: (context,state){return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> MovieDetailScreen(movieId: cardDetails.id,)));
      },
      child: LayoutBuilder(
        builder: (context,constraint){
          return  SizedBox(
            child: Column(
              children: [
                CachedNetworkImage(

                  height: constraint.maxHeight*0.8,
                  width: constraint.maxWidth,
                  imageUrl: "$imageBaseUrl${cardDetails.posterPath}",
                  fit: BoxFit.fill,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  height: constraint.maxHeight*0.2,
                  color: Colors.yellow,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: (constraint.maxWidth*0.6),
                              child: Text(cardDetails.originalTitle,maxLines: 1,overflow: TextOverflow.ellipsis)),
                          Text("${cardDetails.mediaType}, ${cardDetails.originalLanguage}",overflow: TextOverflow.ellipsis,)
                        ],
                      ),
                      IconButton(onPressed: (){
                        context.read<HiveStorageBloc>().add(AddMovieToHiveListEvent(movieData: cardDetails));
                      }, icon: state.movies.contains(cardDetails) ?const Icon(Icons.favorite):const Icon(Icons.favorite_outline_rounded)),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );});
  }
}
