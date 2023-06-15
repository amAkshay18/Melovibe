import 'package:hive/hive.dart';
part 'songdetails.g.dart';

@HiveType(typeId: 0)
class SongDetails extends HiveObject {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? artist;
  @HiveField(2)
  final int? duration;
  @HiveField(3)
  final int? id;
  @HiveField(4)
  final String? url;

  SongDetails(
      {required this.name,
      required this.artist,
      required this.duration,
      required this.id,
      required this.url});
}
