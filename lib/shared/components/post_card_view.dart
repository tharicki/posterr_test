import 'package:flutter/material.dart';
import 'package:strider/data/models/post.dart';
import 'package:strider/data/models/user.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final bool? isRepost;
  final bool? isQuote;
  final User? repostAuthor;

  const PostCard(
      {Key? key,
      required this.post,
      this.isRepost,
      this.isQuote,
      this.repostAuthor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: isRepost != null && isRepost == true,
              child: Row(
                children: [
                  const Icon(
                    Icons.repeat,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    repostAuthor != null ? repostAuthor!.name! : "",
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                  Text("'s",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  const SizedBox(width: 2),
                  Text("repost",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Container(
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.account_circle,
                      color: Colors.purple,
                      size: 58,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    post.author!.name!,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  child: Text(post.description!,
                      style: const TextStyle(fontSize: 14)),
                )
              ],
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: isQuote == null || isQuote == true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Row(
                      children: const [
                        Icon(
                          Icons.repeat,
                          size: 18,
                        ),
                        SizedBox(width: 2),
                        Text("Repost"),
                      ],
                    ),
                    onTap: () {
                      showAboutDialog(context: context);
                    },
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    child: Row(
                      children: const [
                        Icon(
                          Icons.edit,
                          size: 18,
                        ),
                        SizedBox(width: 2),
                        Text("Quote")
                      ],
                    ),
                    onTap: () {
                      showAboutDialog(context: context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
