import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_app/screens/add_movie_screen.dart';

import '../models/movie.dart';

class MovieListScreen extends StatelessWidget {
  MovieListScreen({super.key});

  final Box<Movie> movieBox = Hive.box<Movie>("movies");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Movie List",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.brown[600],
      ),
      body: ValueListenableBuilder(
        valueListenable: movieBox.listenable(),
        builder: (BuildContext context, Box<Movie> box, _) {
          return AnimationLimiter(
            child: ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final movie = box.getAt(index);

                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: ListTile(
                        leading: Image.file(File(movie!.imagePath)),
                        title: Text(movie.name),
                        subtitle: Text(movie.director),
                        trailing: IconButton(
                            onPressed: () {
                              //delete from the box
                              box.deleteAt(index);
                            },
                            icon: const Icon(Icons.delete)),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigate to the add movie screen
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddMovieScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
