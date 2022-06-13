import 'package:flutter/material.dart';
import 'package:strider/data/models/post.dart';
import 'package:strider/presentation/bloc/home/home_bloc.dart';
import 'package:strider/presentation/pages/user_page.dart';
import 'package:strider/shared/app_theme.dart';
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
            if (state is HomeSucess) {

              List<Post> myPosts = state.posts;
              return Container(
                margin: const EdgeInsets.all(4),
                child: ListView(
                  children: _postsCards(myPosts),
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
        onPressed: () {},
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
                Nav.push(context, const HomePage(), replace: true);
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Nav.push(context, UserPage());
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _postsCards(List<Post> posts) {
    List<Widget> cardsPosts = [];

    // quoted post
    cardsPosts.add(QuotedPostCard(post: posts[1], quotedPost: posts[3]));

    //repost post
    cardsPosts.add(PostCard(post: posts[0],
        isRepost: true, isQuote: true, repostAuthor: posts[1].author));

    //other regular posts
    for (var element in posts) {
      cardsPosts.add(PostCard(post: element));
    }

    return cardsPosts;
  }
}
