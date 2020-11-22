import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:marble_gallery/src/models/movie_model.dart';


class CardSwiper extends StatelessWidget {

  final List<Movie> movies;
  
  CardSwiper({ @required this.movies });


  @override
  Widget build(BuildContext context) {

    final _screemSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
        child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screemSize.width * 0.7,
          itemHeight: _screemSize.height * 0.5,
          itemBuilder: (BuildContext context, int index){

            movies[index].uniqueId = '${ movies[index].id }-card';

            return Hero(
                  tag: movies[index].uniqueId,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, 'detail', arguments: movies[index]),
                      child: FadeInImage(
                        image: NetworkImage(movies[index].getPosterImg()),
                        placeholder: AssetImage('assets/loading_blog.gif'),
                        fit: BoxFit.cover
                ),
                    )
              ),
            );
          },
          itemCount: movies.length,
        ),
    );
  }
}