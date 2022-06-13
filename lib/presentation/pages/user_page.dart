import 'package:flutter/material.dart';
import 'package:strider/data/models/post.dart';
import 'package:strider/data/models/user.dart';
import 'package:strider/presentation/bloc/home/home_bloc.dart';
import 'package:strider/presentation/bloc/user/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:strider/presentation/pages/new_post_page.dart';
import 'package:strider/shared/app_theme.dart';
import 'package:strider/shared/components/post_card_view.dart';
import 'package:strider/shared/utils/navigator.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserBloc userBloc = UserBloc();
  final HomeBloc homeBloc = HomeBloc();

  late List<Post> myPosts;

  @override
  void initState() {
    homeBloc.add(OnLoadProfile(userId: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("My Profile"),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.theme.primaryColor,
        onPressed: () {
          Nav.push(
              context,
              NewPostPage(
                  author: User(id: 1),
                  callback: () {
                    setState(() {});
                  }));
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<UserBloc, UserState>(
          bloc: userBloc..add(OnLoadUser(id: 1)),
          builder: ((context, state) {
            if (state is UserSuccess) {
              User myUser = state.user;

              return ListView(
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          AssetImage('assets/images/tharicki_pic.jpg'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    myUser.name!,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                          "Posterr user since ${DateFormat.yMMMd().format(myUser.joinDate!)}",
                          style: const TextStyle(fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text("Posts: ${myUser.postsCount},",
                          style: const TextStyle(fontSize: 15)),
                      const SizedBox(width: 3),
                      Text("Reposts: ${myUser.repostsCount}",
                          style: const TextStyle(fontSize: 15)),
                      const SizedBox(width: 3),
                      Text("Quote-posts: ${myUser.quotedCount}",
                          style: const TextStyle(fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Divider(height: 5, color: Colors.grey),
                  const SizedBox(height: 5),
                  BlocBuilder<HomeBloc, HomeState>(
                    bloc: homeBloc,
                    builder: ((context, state) {
                      if (state is HomeProfileSucess) {
                        myPosts = state.posts;
                        return Column(
                          children: _postsCards(myPosts),
                        );
                      }

                      return const SizedBox(
                        height: 100.0,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            }
            return const SizedBox(
              height: 500.0,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  List<Widget> _postsCards(List<Post> myPosts) {
    List<Widget> cardsPosts = [];

    //repost post
    cardsPosts.add(PostCard(
        post: myPosts[0],
        isRepost: true,
        isQuote: true,
        repostAuthor: myPosts[1].author));

    //other regular posts
    for (var element in myPosts) {
      cardsPosts.add(PostCard(post: element));
    }

    return cardsPosts;
  }

  void _refresh() async {
    homeBloc.add(OnLoadProfile(userId: 1));
  }
}
