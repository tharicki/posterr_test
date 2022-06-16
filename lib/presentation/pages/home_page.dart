import 'package:flutter/material.dart';
import 'package:strider/data/mock_data.dart';
import 'package:strider/data/models/post.dart';
import 'package:strider/data/models/user.dart';
import 'package:strider/presentation/bloc/home/home_bloc.dart';
import 'package:strider/presentation/bloc/user/user_bloc.dart';
import 'package:strider/presentation/pages/new_post_page.dart';
import 'package:strider/presentation/pages/user_page.dart';
import 'package:strider/shared/app_theme.dart';
import 'package:strider/shared/components/alert_dialog.dart';
import 'package:strider/shared/components/post_card_view.dart';
import 'package:strider/shared/components/quoted_post_card_view.dart';
import 'package:strider/shared/utils/navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc homeBloc = HomeBloc();
  final UserBloc userBloc = UserBloc();

  late List<Post> myPosts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Posterr"),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc..add(OnLoadHome()),
        builder: ((context, state) {
          if (state is HomeSuccess) {
            myPosts = state.posts;
            return Container(
              margin: const EdgeInsets.all(4),
              child: ListView(
                children: _postsCards(myPosts.reversed.toList()),
              ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.theme.primaryColor,
        onPressed: () {
          //here we should have the user data on our bloc to pass as parameter
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountEmail: Text("tharicki@gmail.com"),
              accountName: Text("Tharicki Pereira"),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/tharicki_pic.jpg')),
              currentAccountPictureSize: Size(70, 70),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Nav.push(context, const HomePage());
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Nav.push(context, const UserPage());
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _postsCards(List<Post> posts) {
    List<Widget> cardsPosts = [];

    for (var post in posts) {
      if (post.isQuote!) {
        post.quotePost = posts[1];

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
