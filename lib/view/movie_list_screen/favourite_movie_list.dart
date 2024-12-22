part of 'movie_list_screen.dart';
class FavouriteListScreen extends StatefulWidget {
  const FavouriteListScreen({super.key});

  @override
  State<FavouriteListScreen> createState() => _FavouriteListScreenState();
}

class _FavouriteListScreenState extends State<FavouriteListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Favourite List"),
          leading: Icon(Icons.menu),
          actions: [IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))],
        ),
        body: BlocBuilder<HiveStorageBloc,HiveStorageState>(
            builder: (context,state){
              switch(state.hiveStorageStatus){

                case HiveStorageStatus.initial:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case HiveStorageStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case HiveStorageStatus.success:
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: GridView.builder(gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 3.0,
                      mainAxisSpacing: 3.0,
                      childAspectRatio: 1.1 / 2,),
                        itemCount: state.movies.length,
                        itemBuilder: (context,index){
                          return MovieListCard(cardDetails: state.movies[index],key: ValueKey(state.movies[index].id),);
                        }),
                  );
                case HiveStorageStatus.failure:
                  return const Text("Somthing went wrong");
              }

            })
    );
  }
}