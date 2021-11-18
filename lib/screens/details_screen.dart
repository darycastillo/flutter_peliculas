import 'package:flutter/material.dart';
import 'package:flutter_peliculas_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: cambiar por una instacias

    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const _CustomAppBar(),
        SliverList(
          delegate: SliverChildListDelegate(const [
            _PosteraAndTittle(),
            _OverView(),
            _OverView(),
            CastingCards()
          ]),
        )
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        centerTitle: true,
        title: Container(
            color: Colors.black12,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 10),
            child: const Text('titulo',
                style: TextStyle(
                  fontSize: 16,
                ))),
        background: const FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage("https://via.placeholder.com/500x300"),
            fit: BoxFit.cover),
      ),
    );
  }
}

class _PosteraAndTittle extends StatelessWidget {
  const _PosteraAndTittle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'movie.title',
                style: textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                'movie.originalTitle',
                style: textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_outline,
                    size: 15,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Text('movie.voteAverage', style: textTheme.caption)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  const _OverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        'Laborum cillum ad culpa Lorem eu ipsum do culpa qui eu nulla. Ullamco mollit enim dolore nulla laboris dolor labore sit. Sit officia velit veniam enim enim. Est sint esse sit laboris incididunt nulla et ullamco id exercitation ad. Labore ex dolor magna sit eu. Cillum sint mollit exercitation ea tempor occaecat voluptate minim dolore pariatur proident exercitation est. Minim eu exercitation laborum consectetur anim deserunt qui consectetur duis sint adipisicing. Adipisicing pariatur proident velit eu excepteur enim voluptate et mollit cillum nostrud nulla. Nisi occaecat do officia aute aliquip nulla enim commodo mollit enim consequat commodo pariatur. Excepteur eiusmod laboris in eu do veniam proident. Culpa officia aliqua culpa nisi est nulla est ullamco anim nostrud excepteur mollit.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
