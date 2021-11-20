import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_peliculas_app/models/models.dart';
import 'package:flutter_peliculas_app/providers/movies_provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  Widget _emptyContainer() {
    return const Center(
        child: Icon(Icons.movie_creation_outlined,
            color: Colors.black38, size: 100));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }
    final moviesProvider = Provider.of<MoviesProvider>(context);
    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final movies = snapshot.data!;

        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, int index) => _MovieItem(movies[index]));
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie _movie;
  const _MovieItem(this._movie);

  @override
  Widget build(BuildContext context) {
    _movie.heroId = 'search-${_movie.id}';
    return Column(
      children: [
        Hero(
          tag: _movie.heroId!,
          child: ListTile(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: _movie),
            title: Text(_movie.title),
            leading: ClipRRect(
              // borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(_movie.fullbackdropPathImg),
                  fit: BoxFit.cover,
                  height: 64,
                  width: 64),
            ),
          ),
        ),
        const Divider(
          // indent: 80,
          color: Colors.black54,
        )
      ],
    );
  }
}
