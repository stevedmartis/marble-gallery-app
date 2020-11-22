import 'package:flutter/material.dart';
import 'package:marble_gallery/src/models/movie_model.dart';
import 'package:marble_gallery/src/providers/movies_provider.dart';


class DataSearch extends SearchDelegate{

  String selection = '';
  final moviesProvider = new MoviesProvider();

  final movies = [
    'spiderman',
    'wolverine',
    'hulk'

  ];

  final moviesRecent = [
    'spiderman',
    'wolverine',
    'hulk'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
          color: Colors.blueAccent,
          child: Text(selection),
      ),
    );
  }


@override
Widget buildSuggestions(BuildContext context) {

  if ( query.isEmpty) {
    return Container();
  }

  return FutureBuilder(
    future: moviesProvider.searchMovie(query),
    builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {

        if (snapshot.hasData){

          final movies = snapshot.data;

          

          return ListView(
            children: movies.map( (movie) {
               movie.uniqueId = '${ movie.id }-poster';
              return Hero(
                      tag: movie.uniqueId,
                      child: ListTile(
                  leading: FadeInImage(
                    image: NetworkImage( movie.getPosterImg() ),
                    placeholder: AssetImage('assets/img/cam.jpg'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text( movie.title ),
                  subtitle: Text( movie.originalTitle ),
                  onTap: () {
                    close( context, null);
                    movie.uniqueId = '';
                    Navigator.pushNamed(context, 'detail', arguments: movie);
                  },
                ),
              );
            }).toList(),
          );

        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
     
        

        
    },
  );

}

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // TODO: implement buildSuggestions

  //   final suggestionList = ( query.isEmpty )
  //                             ? moviesRecent
  //                             : movies.where( 
  //                               (m)=> m.toLowerCase().startsWith(query.toLowerCase())
  //                             ).toList(); 

  //   return ListView.builder(
  //     itemCount: suggestionList.length,
  //     itemBuilder: (context, i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(suggestionList[i]),
  //         onTap: () { 
  //           selection = suggestionList[i];
  //         },

  //       );
  //     },
  //   );
  // }

}
