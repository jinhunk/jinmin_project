class MeetingFeed {
  int meetingIdx;
  int userIdx;
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

  MeetingFeed(
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
      required this.favoriteCount});

  factory MeetingFeed.fromjson(Map<String, dynamic> json) {
    return MeetingFeed(
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
    );
  }
}
