import 'package:hive/hive.dart';

part 'movie.g.dart';

@HiveType(typeId: 0)
class Movie extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String director;

  @HiveField(2)
  late String  imagePath;
}
