import 'package:strider/data/models/user.dart';

class Post {
  int? id;
  String? description;
  User? author;
  DateTime? dateTime;

  Post({
    this.id,
    this.description,
    this.author,
    this.dateTime,
  });
}
