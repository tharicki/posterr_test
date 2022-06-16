import 'package:flutter/material.dart';
import 'package:strider/data/models/post.dart';
import 'package:strider/data/models/user.dart';
import 'package:strider/presentation/bloc/home/home_bloc.dart';
import 'package:strider/presentation/bloc/user/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:strider/presentation/pages/new_post_page.dart';
import 'package:strider/shared/app_theme.dart';
import 'package:strider/shared/components/alert_dialog.dart';
import 'package:strider/shared/components/post_card_view.dart';
import 'package:strider/shared/components/quoted_post_card_view.dart';
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
                  //validate to show only 14 characters of name
                  Text(
                    myUser.name!.length > 14
                        ? '${myUser.name!.substring(0, 13)}...'
                        : myUser.name!,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
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
                    bloc: homeBloc..add(OnLoadProfile(userId: 1)),
                    builder: ((context, state) {
                      if (state is HomeProfileSucess) {
                        myPosts = state.posts;
                        return Column(
                          children: _postsCards(myPosts.reversed.toList()),
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

    for (var post in myPosts) {
      if (post.isQuote!) {
        post.quotePost = myPosts[1];
        post.quotePost!.isQuote = true;

        cardsPosts.add(QuotedPostCard(post: post, quotedPost: post.quotePost!));
      } else {
        cardsPosts.add(PostCard(post: post, onRepostTap: () {
          repost(post);
        }, onQuoteTap: () {
          quote(post);
        },));
      }
    }

    return cardsPosts;
  }

  void repost(Post post) {
    showCustomAlertDialog(
        context: context,
        title: "Confirm this action",
        text: "Do you want to repost this?",
        confirmButtonTap: () {
          Post newPost = Post();
          newPost.description = post.description;
          newPost.isQuote = post.isQuote;
          newPost.quotePost = post.quotePost;
          newPost.author = post.author;
          newPost.isRepost = true;


          homeBloc.add(OnNewPost(post: newPost));

          setState((){});
        });
  }

  void quote(Post post) {
    final TextEditingController postController = TextEditingController();
    showCustomAlertDialog(
        context: context,
        title: "Insert your message to quote this post",
        text: "",
        textField: TextField(
          onChanged: (value) { },
          controller: postController,
          decoration: const InputDecoration(hintText: "Quote message"),
        ),
        confirmButtonTap: () {
          Post newPost = Post();
          newPost.description = postController.text;
          newPost.isQuote = true;
          newPost.quotePost = post.quotePost;
          newPost.author = post.author;
          newPost.isRepost = false;

          homeBloc.add(OnNewPost(post: newPost));

          setState((){});
        });
  }
}
