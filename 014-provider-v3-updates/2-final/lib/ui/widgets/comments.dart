import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_arc/core/changenotifiers/widgets/comments_notifier.dart';
import 'package:provider_arc/core/models/comment.dart';
import 'package:provider_arc/ui/shared/app_colors.dart';
import 'package:provider_arc/ui/shared/ui_helpers.dart';
import 'package:provider_arc/ui/widgets/base_widget.dart';

class Comments extends StatelessWidget {
  final int postId;
  Comments(this.postId);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CommentsNotifier>(
      onNotifierReady: (notifier) => notifier.fetchComments(postId) ,
      notifier: CommentsNotifier(api: Provider.of(context)),
      builder: (context, model, child) => model.busy
          ? Center(child: CircularProgressIndicator())
          : Expanded(
              child: ListView(
                children: model.comments
                    .map((comment) => CommentItem(comment))
                    .toList(),
              ),
            ),
    );
  }
}

/// Renders a single comment given a comment model
class CommentItem extends StatelessWidget {
  final Comment comment;
  const CommentItem(this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: commentColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            comment.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          UIHelper.verticalSpaceSmall,
          Text(comment.body),
        ],
      ),
    );
  }
}
