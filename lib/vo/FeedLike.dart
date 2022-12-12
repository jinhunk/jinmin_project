class FeedLike {
  int feedLikeIdx;
  int meetingFeedIdx;
  int userIdx;

  FeedLike({
    required this.feedLikeIdx,
    required this.meetingFeedIdx,
    required this.userIdx,
  });

  factory FeedLike.fromJson(Map<String, dynamic> json) {
    return FeedLike(
      feedLikeIdx: json['feed_like_idx'],
      meetingFeedIdx: json['meeting_feed_idx'],
      userIdx: json['user_idx'],
    );
  }
}
