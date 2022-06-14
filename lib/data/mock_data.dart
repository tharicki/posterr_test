import 'dart:async';

import 'package:strider/data/models/post.dart';
import 'package:strider/data/models/user.dart';

int dayPosts = 0;

var users = [
  User(
      id: 1,
      name: "Tharicki",
      lastName: "Pereira",
      joinDate: DateTime(2022, 1, 5, 14, 21),
      postsCount: 7,
      quotedCount: 3,
      repostsCount: 9),
  User(
      id: 2,
      name: "Emiliane",
      lastName: "Espindola",
      postsCount: 1,
      quotedCount: 3,
      joinDate: DateTime(2022, 1, 5, 14, 21)),
  User(
      id: 3,
      name: "Alex",
      lastName: "Silva",
      postsCount: 3,
      quotedCount: 1,
      joinDate: DateTime(2022, 1, 5, 14, 21)),
  User(
      id: 4,
      name: "John",
      lastName: "Anderson",
      postsCount: 1,
      quotedCount: 1,
      joinDate: DateTime(2022, 1, 5, 14, 21)),
];

var posts = [
  Post(
      id: 1,
      description:
          'Hello! This is my first post here. Im in love with this new social media!',
      dateTime: DateTime(2022, 5, 5, 14, 21),
      isQuote: false,
      isRepost: false,
      author: users[0]),
  Post(
      id: 2,
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      dateTime: DateTime(2022, 5, 10, 13, 04),
      isQuote: false,
      isRepost: false,
      author: users[1]),
  Post(
      id: 3,
      description:
          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
      dateTime: DateTime(2022, 6, 4, 18, 30),
      isQuote: false,
      isRepost: true,
      repostAuthor: users[1],
      author: users[2]),
  Post(
      id: 4,
      description:
          "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
      dateTime: DateTime(2022, 6, 5, 19, 16),
      isQuote: true,
      isRepost: false,
      repostAuthor: users[1],
      author: users[3]),
  Post(
      id: 5,
      description:
          "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages",
      dateTime: DateTime(2022, 6, 10, 23, 02),
      isQuote: false,
      isRepost: true,
      repostAuthor: users[3],
      author: users[0]),
];

class MockData {
  Future<List<User>> getUsers() async {
    await Future.delayed(const Duration(milliseconds: 250), () {});
    return users;
  }

  Future<User> getUserById(int id) async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    User myUser = users.firstWhere((element) => element.id == id);
    return myUser.id != null ? myUser : User();
  }

  Future<List<Post>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    return posts;
  }

  Future<List<Post>> getPostsByUser(int userId) async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    List<Post> myPosts =
        posts.where((element) => element.author!.id == userId).toList();
    return myPosts;
  }

  Future<void> newPost(Post post) async {
    posts.add(post);
  }

  void incrementDayPosts() {
    dayPosts++;
  }

  int getDayPosts() {
    return dayPosts;
  }
}
