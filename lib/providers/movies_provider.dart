import 'package:flutter/material.dart';
import 'package:flutter_peliculas_app/models/models.dart';

import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '7c169f3bcf6edf7aed2794f9191697ff';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];
  int _popularMoviesPage = 0;

  MoviesProvider() {
    getOnDisplayMovies();
    getPoularMovie();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    final response = await http.get(url);
    return response.body;
  }

  void getOnDisplayMovies() async {
    final data = await _getJsonData('/3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(data);
    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  void getPoularMovie() async {
    _popularMoviesPage++;
    final data = await _getJsonData('3/movie/popular', _popularMoviesPage);
    final popularResponse = PopularResponse.fromJson(data);
    onPopularMovies = popularResponse.results;

    notifyListeners();
  }
}
