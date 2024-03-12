import 'package:bullet_news/services/comment_service.dart';
import 'package:flutter/material.dart';

import '../models/comment.dart';

class CommentsList extends StatefulWidget {
  final int newsId;

  const CommentsList({super.key, required this.newsId});

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  final CommentService commentService = CommentService();
  late List<Comment> comments;
  bool _isLoading = true;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    try {
      final fetchedComments =
          await commentService.fetchCommentsForNews(widget.newsId.toString());
      setState(() {
        comments = fetchedComments;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Failed to fetch comments: $e");
    }
  }

  Future<void> _addComment() async {
    String content = _commentController.text.trim();
    if (content.isNotEmpty) {
      try {
        await commentService.addCommentForNews(widget.newsId.toString(), content);
        await _fetchComments();
        _commentController.clear();
      } catch (e) {
        debugPrint("Failed to create comment: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          hintText: 'Add a comment...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: _addComment,
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              comments.isNotEmpty
                  ? SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return Column(
                            children: [
                              ListTile(
                                title: Text(
                                  comment.content,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "By: ${comment.userId}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Text('No comments'),
                    ),
            ],
          );
  }
}
