import 'package:flutter/material.dart';
import 'package:marble_gallery/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  
  final List<Movie> movies;
  final Function nextPage;


  MovieHorizontal({ @required this.movies, @required this.nextPage });

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );
  
  @override
  Widget build(BuildContext context) {

      final _screenSize = MediaQuery.of(context).size;

      _pageController.addListener( () {

        if( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
          nextPage();
        }
      });


      return Container(
        height: _screenSize.height * 0.25,
        child: PageView.builder(
          pageSnapping: false,
          controller: _pageController,
          itemCount: movies.length,
          itemBuilder: ( context, i) => _card(context, movies[i]),
        ),
      );

  }


  Widget _card(BuildContext context, Movie movie){

    movie.uniqueId = '${ movie.id }-poster';

    final _screenSize = MediaQuery.of(context).size;

    final card = Container(
      margin:  EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
           tag: movie.uniqueId,
           child: ClipRRect(
             borderRadius: BorderRadius.circular(20.0),
             child: FadeInImage(
               image: NetworkImage( movie.getPosterImg()),
               placeholder: AssetImage('assets/cam.jpg'),
               fit: BoxFit.cover,
               height: _screenSize.height * 0.20,
             ),
           ),
          ),
          SizedBox(height: 5.0),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption
          )
        ],
      ),
    );

    return GestureDetector(
      child: card,
      onTap: (){
        Navigator.pushNamed(context, 'detail', arguments: movie);
      }
    );
  }

  List<Widget> _cards(context) {
    final _screenSize = MediaQuery.of(context).size;

    return movies.map( ( movie) {

      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(

          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                image: NetworkImage( movie.getPosterImg()),
                placeholder: AssetImage('assets/no_camara.png'),
                fit: BoxFit.cover,
                height: _screenSize.height * 0.20
                ),
            ),
            SizedBox(height: 5.0),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption
            )
          ],
        ),

      );
    }).toList();
  }
}