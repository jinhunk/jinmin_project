class MeetingFeedAndUser {
  int meetingIdx;
  String placeCity;
  String title;
  String content;
  double placeLat;
  double placeLon;
  String imageUrl1;
  String imageUrl2;
  String imageUrl3;
  String feedRegDate;
  int favoriteCount;
  int userIdx;
  String userId;
  String userName;
  int userGender; // 1일경우 남성 0일경우 여성
  int userBorn; // 출생년도
  String userIntro; // 자기소개
  String userAddress;
  String userJob;
  String userProfileUrl;
  String userProfileAnimalUrl;
  MeetingFeedAndUser(
      {required this.meetingIdx,
      required this.userIdx,
      required this.placeCity,
      required this.title,
      required this.content,
      required this.placeLat,
      required this.placeLon,
      required this.imageUrl1,
      required this.imageUrl2,
      required this.imageUrl3,
      required this.feedRegDate,
      required this.favoriteCount,
      required this.userId,
      required this.userName,
      required this.userGender,
      required this.userBorn,
      required this.userIntro,
      required this.userAddress,
      required this.userJob,
      required this.userProfileUrl,
      required this.userProfileAnimalUrl});
  factory MeetingFeedAndUser.fromjson(Map<String, dynamic> json) {
    return MeetingFeedAndUser(
      meetingIdx: json['meeting_idx'],
      userIdx: json['user_idx'],
      placeCity: json['place_city'],
      title: json['title'],
      content: json['content'],
      placeLat: json['place_lat'],
      placeLon: json['place_lon'],
      imageUrl1: json['image_url1'],
      imageUrl2: json['image_url2'],
      imageUrl3: json['image_url3'],
      feedRegDate: json['feed_reg_date'],
      favoriteCount: json['favorite_count'],
      userId: json['user_id'],
      userName: json['user_name'],
      userGender: json['user_gender'],
      userBorn: json['user_born'],
      userIntro: json['user_intro'],
      userAddress: json['user_address'],
      userJob: json['user_job'],
      userProfileUrl: json['user_profile_url'],
      userProfileAnimalUrl: json['user_profileanimal_url'],
    );
  }
}
