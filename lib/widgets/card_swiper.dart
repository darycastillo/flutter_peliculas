import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_peliculas_app/models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: (size.height * 0.5),
      child: Swiper(
        itemCount: (movies.isNotEmpty) ? (movies.length - 1) : 1,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (_, int index) {
          Movie? movie = movies.isNotEmpty ? movies[index] : null;

          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: 'movieksk'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie != null
                      ? movie.fullPosterImg
                      : 'https://i.stack.imgur.com/GNhxO.png'),
                  fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
