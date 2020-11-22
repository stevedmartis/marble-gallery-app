import 'package:marble_gallery/src/models/actors_model.dart';
import 'package:marble_gallery/src/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MoviesProvider {

  String _apikey = '4bc0335f07b79c1a9cf3111e7b778f89';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularPage = 0;
  bool _loading = false;

  List<Movie> _popular = new List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposeStreams(){
    _popularStreamController?.close();
  }

Future<List<Movie>> _answerMethod(Uri url) async {

final resp = await http.get( url );

final decodeData = json.decode(resp.body);

final movies = new Movies.formJsonLista(decodeData['results']);

return (movies.items);

}

Future<List<Movie>> getMovies() async{

final url = Uri.https(_url, '3/movie/now_playing', {
  'api_key' : _apikey,
  'language':   _language
});

return await _answerMethod(url);

}

Future<List<Movie>> getPopulares() async {

  if( _loading ) return [];

  _loading = true;

  _popularPage++;

  final url = Uri.https(_url, '3/movie/popular', {
  'api_key' : _apikey,
  'language':   _language,
  'page':     _popularPage.toString()
});

final resp = await _answerMethod(url);

_popular.addAll(resp);
popularSink( _popular );

_loading = false;

return resp;



}

Future<List<Actor>> getCast( String movieId ) async {

final url = Uri.http(_url, '3/movie/$movieId/credits', {
  'api_key' : _apikey,
  'language':   _language
});

final resp = await http.get(url);
final decodeData = json.decode( resp.body );
final cast = new Cast.fromJsonList( decodeData['cast'] );


return cast.actors;
  
}


Future<List<Movie>> searchMovie( String query ) async {

final url = Uri.http(_url, '3/search/movie', {
  'api_key' : _apikey,
  'language':   _language,
  'query':      query
});



return await _answerMethod(url);
  
}

}