class User {
  int? id;
  String? name;
  String? lastName;
  DateTime? born;
  DateTime? joinDate;
  int? postsCount;
  int? repostsCount;
  int? quotedCount;
  int? dayPosts;

  User({
    this.id,
    this.name,
    this.lastName,
    this.born,
    this.joinDate,
    this.postsCount,
    this.repostsCount,
    this.quotedCount,
    this.dayPosts
  });
}
