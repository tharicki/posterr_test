import 'package:strider/data/models/user.dart';

class Post {
  int? id;
  String? description;
  User? author;
  DateTime? dateTime;
  bool? isRepost;
  bool? isQuote;
  User? repostAuthor;
  Post? quotePost;

  Post(
      {this.id,
      this.description,
      this.author,
      this.dateTime,
      this.isRepost,
      this.isQuote,
      this.repostAuthor,
      this.quotePost});
}
