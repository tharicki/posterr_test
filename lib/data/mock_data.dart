import 'dart:async';

import 'package:strider/data/models/post.dart';
import 'package:strider/data/models/user.dart';

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
      joinDate: DateTime(2022, 1, 5, 14, 21)),
  User(
      id: 3,
      name: "Alex",
      lastName: "Silva",
      joinDate: DateTime(2022, 1, 5, 14, 21)),
  User(
      id: 4,
      name: "Tharicki",
      lastName: "Pereira",
      joinDate: DateTime(2022, 1, 5, 14, 21)),
];

var posts = [
  Post(
      id: 1,
      description:
      'Hello! This is my first post here. Im in love with this new social media!',
      dateTime: DateTime(2022, 5, 5, 14, 21),
      author: users[0]),
  Post(
      id: 2,
      description:
      'Hello! This is my first post here. Im in love with this new social media!',
      dateTime: DateTime(2022, 5, 10, 13, 04),
      author: users[1]),
  Post(
      id: 3,
      description:
      'Hello! This is my first post here. Im in love with this new social media!',
      dateTime: DateTime(2022, 6, 4, 18, 30),
      author: users[2]),
  Post(
      id: 4,
      description:
      'Hello! This is my first post here. Im in love with this new social media!',
      dateTime: DateTime(2022, 6, 5, 19, 16),
      author: users[3]),
  Post(
      id: 5,
      description:
      'Hello! This is my first post here. Im in love with this new social media!',
      dateTime: DateTime(2022, 6, 10, 23, 02),
      author: users[0]),
  Post(
      id: 6,
      description:
      'Hello! This is my first post here. Im in love with this new social media!',
      dateTime: DateTime(2022, 6, 10, 23, 02),
      author: users[0]),
  Post(
      id: 7,
      description:
      'Hello! This is my first post here. Im in love with this new social media!',
      dateTime: DateTime(2022, 6, 10, 23, 02),
      author: users[0]),
];

class MockData {

  Future<List<User>> getUsers() async {
    await Future.delayed(const Duration(milliseconds: 250), () {});
    return users;
  }

  Future<User> getUserById(int id) async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    User myUser = users.firstWhere((element) => element.id == id);
    return myUser.id != null ? myUser : User();
  }

  Future<List<Post>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    return posts;
  }

  Future<List<Post>> getPostsByUser(int userId) async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    List<Post> myPosts = posts.where((element) => element.author!.id == userId).toList();
    return myPosts;
  }

}