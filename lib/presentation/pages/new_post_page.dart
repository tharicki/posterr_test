import 'package:flutter/material.dart';
import 'package:strider/data/models/post.dart';
import 'package:strider/data/models/user.dart';
import 'package:strider/presentation/bloc/home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strider/shared/utils/navigator.dart';

typedef PostCallback = Function();

class NewPostPage extends StatelessWidget {
  final PostCallback callback;
  final User author;
  final HomeBloc homeBloc = HomeBloc();
  final TextEditingController _postController = TextEditingController();

  late Post newPost;

  NewPostPage({Key? key, required this.callback, required this.author})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Post it!"),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();

                  newPost = Post(
                      description: _postController.text,
                      dateTime: DateTime.now(),
                      author: author);

                  homeBloc.add(OnNewPost(post: newPost));
                },
                icon: const Icon(Icons.save)),
          ],
        ),
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is NewPostSuccess) {
              callback.call();
              Nav.pop(context);
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            bloc: homeBloc,
            builder: ((context, state) {
              if (state is HomeLoading) {
                return Column(
                  children: const [
                    SizedBox(
                      height: 120,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text("Posting you content, please wait!")
                  ],
                );
              }
              if (state is HomeInitial) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(12),
                        height: 6 * 24.0,
                        child: TextField(
                          maxLines: 6,
                          maxLength: 777,
                          controller: _postController,
                          decoration: InputDecoration(
                            hintText: "Enter your message",
                            fillColor: Colors.grey[200],
                            hoverColor: Colors.grey[200],
                            filled: true,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                            ),
                            errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container(
                color: Colors.grey[100],
              );
            }),
          ),
        ),
      ),
    );
  }
}
