import 'package:flutter/material.dart';
import 'package:strider/data/models/post.dart';
import 'package:strider/shared/components/post_card_view.dart';

class QuotedPostCard extends StatelessWidget {
  final Post post;
  final Post quotedPost;
  final Function? onRepostTap;
  final Function? onQuoteTap;

  const QuotedPostCard(
      {Key? key,
      required this.post,
      required this.quotedPost,
      this.onRepostTap,
      this.onQuoteTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
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
            const SizedBox(height: 6),
            PostCard(post: quotedPost),
            const SizedBox(height: 6),
            Row(
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
                    onRepostTap;
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
                    onQuoteTap;
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
