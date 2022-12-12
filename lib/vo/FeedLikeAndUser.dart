class FeedLikeAndUser {
  int feedLikeIdx;
  int meetingFeedIdx;
  int userIdx;
  String userId;
  String userName;
  int userGender; // 1일경우 남성 0일경우 여성
  int userBorn; // 출생년도
  String userIntro; // 자기소개
  String userAddress;
  String userJob;
  String userProfileUrl;

  FeedLikeAndUser({
    required this.feedLikeIdx,
    required this.meetingFeedIdx,
    required this.userIdx,
    required this.userId,
    required this.userName,
    required this.userGender,
    required this.userBorn,
    required this.userIntro,
    required this.userAddress,
    required this.userJob,
    required this.userProfileUrl,
  });

  factory FeedLikeAndUser.fromJson(Map<String, dynamic> json) {
    return FeedLikeAndUser(
      feedLikeIdx: json['feed_like_idx'],
      meetingFeedIdx: json['meeting_feed_idx'],
      userIdx: json['user_idx'],
      userId: json['user_id'],
      userName: json['user_name'],
      userGender: json['user_gender'],
      userBorn: json['user_born'],
      userIntro: json['user_intro'],
      userAddress: json['user_address'],
      userJob: json['user_job'],
      userProfileUrl: json['user_profile_url'],
    );
  }
}
