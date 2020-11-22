import 'package:flutter/material.dart';
import 'package:marble_gallery/src/search/search_delegate.dart';
import 'package:marble_gallery/src/widgets/card_swiper_widget.dart';
import 'package:marble_gallery/src/providers/movies_provider.dart';
import 'package:marble_gallery/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {

    moviesProvider.getPopulares();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search ),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            }
            )
        ],
      ),
      body: Container(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _footerMovies(context)
          ],
        )
      ),
    );
  }


  Widget _swiperCards() {

    return FutureBuilder(
      future: moviesProvider.getMovies(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if(snapshot.hasData){
          return CardSwiper(movies: snapshot.data);
        }
        else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
  

      
      },
    );

  
  }


  Widget _footerMovies(BuildContext context){

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead)),
          SizedBox(
            height: 5.0
          ),

          StreamBuilder(
            stream: moviesProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

              if( snapshot.hasData ){
                return MovieHorizontal( 
                  movies: snapshot.data,
                  nextPage: moviesProvider.getPopulares
                );
              }

              else {
                return Center(
                  child: CircularProgressIndicator()
                );
              }


            },
          ),          
        ],
      ),
    );
  }


}