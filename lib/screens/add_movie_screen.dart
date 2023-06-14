import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_app/models/movie.dart';

class AddMovieScreen extends StatefulWidget {
  const AddMovieScreen({super.key});

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _directorController = TextEditingController();
  File? posterImage;

  Future<void> _selectPosterImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        posterImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveMovie() async {
    final movieBox = Hive.box<Movie>("movies");

    final newMovie = Movie()
      ..name = _nameController.text
      ..director = _directorController.text
      ..imagePath = posterImage!.path;

    movieBox.add(newMovie);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _directorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
        title: const Text("Add Movie"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
          TextField(
            controller: _directorController,
            decoration: const InputDecoration(
              labelText: 'Director',
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
              onPressed: _selectPosterImage,
              child: const Text("Select Poster Image")),
          const SizedBox(
            height: 16.0,
          ),
          if (posterImage != null)
            Image.file(
              posterImage!,
              width: 200,
              height: 140,
              fit: BoxFit.cover,
            ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(onPressed: _saveMovie, child: const Text("Save Movie"))
        ]),
      ),
    );
  }
}
