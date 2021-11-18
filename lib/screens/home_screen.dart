import 'package:flutter/material.dart';
import 'package:flutter_peliculas_app/providers/movies_provider.dart';
import 'package:flutter_peliculas_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context
        /* listen: true) */ //pro defecto esta en true
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          //Tarjetas principales
          CardSwiper(movies: moviesProvider.onDisplayMovies),
          //Slider de peliculas
          MovieSlider(),
        ]),
      ),
    );
  }
}
