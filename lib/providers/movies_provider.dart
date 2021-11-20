import 'package:flutter/material.dart';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:flutter_peliculas_app/models/models.dart';
import 'package:flutter_peliculas_app/helpers/debouncer.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '7c169f3bcf6edf7aed2794f9191697ff';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];
  int _popularMoviesPage = 0;

  Map<int, List<Cast>> moviesCast = {};

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionsStreamController =
      StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      _suggestionsStreamController.stream;

  MoviesProvider() {
    getOnDisplayMovies();
    getPoularMovie();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint,
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

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final data =
        await _getJsonData('3/movie/$movieId/credits', _popularMoviesPage);
    final creditsResponse = CreditsResponse.fromJson(data);
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searcMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
      'query': query
    });
    final response = await http.get(url);
    final searchMoviesResponse = SearchMovieResponse.fromJson(response.body);

    return searchMoviesResponse.results;
  }

  void getSuggestionsByQuery(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final result = await searcMovies(value);
      _suggestionsStreamController.add(result);
    };

    var timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
