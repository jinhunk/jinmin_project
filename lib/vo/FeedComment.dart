class FeedComment {
  int feedCommentIdx;
  int meetingFeedIdx;
  String commentContent;
  String commentRegDate;
  int userIdx;

  FeedComment({
    required this.feedCommentIdx,
    required this.meetingFeedIdx,
    required this.commentContent,
    required this.commentRegDate,
    required this.userIdx,
  });

  factory FeedComment.fromjson(Map<String, dynamic> json) {
    return FeedComment(
      feedCommentIdx: json['feed_comment_idx'],
      meetingFeedIdx: json['meeting_feed_idx'],
      commentContent: json['comment_content'],
      commentRegDate: json['comment_reg_date'],
      userIdx: json['user_idx'],
    );
  }
}
