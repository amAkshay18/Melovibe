import 'package:hive/hive.dart';
part 'fav_model.g.dart';

@HiveType(typeId: 2)
class FavourModel extends HiveObject {
  @HiveField(0)
  int? id;

  FavourModel({required this.id});
}
