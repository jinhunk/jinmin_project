class FriendShipAndUser {
  int friendShipIdx;
  int fromUserIdx; //신청자
  int toUserIdx; //신청받은사람
  int alloW; //신청받은사람이 허락했는지? 0이면 허락x 1이면 허락o
  int userIdx;
  String userId;
  String userName;
  int userGender; // 1일경우 남성 0일경우 여성
  int userBorn; // 출생년도
  String userIntro; // 자기소개
  String userAddress;
  String userJob;
  String userProfileUrl;

  FriendShipAndUser(
      {required this.friendShipIdx,
      required this.fromUserIdx,
      required this.toUserIdx,
      required this.alloW,
      required this.userIdx,
      required this.userId,
      required this.userName,
      required this.userGender,
      required this.userBorn,
      required this.userIntro,
      required this.userAddress,
      required this.userJob,
      required this.userProfileUrl});

  factory FriendShipAndUser.fromjson(Map<String, dynamic> json) {
    return FriendShipAndUser(
      friendShipIdx: json['friend_ship_idx'],
      fromUserIdx: json['from_user_idx'],
      toUserIdx: json['to_user_idx'],
      alloW: json['allow'],
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
