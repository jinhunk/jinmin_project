class User {
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

  User(
      {required this.userIdx,
      required this.userId,
      required this.userName,
      required this.userGender,
      required this.userBorn,
      required this.userIntro,
      required this.userAddress,
      required this.userJob,
      required this.userProfileUrl,
      required this.userProfileAnimalUrl});

  factory User.fromjson(Map<String, dynamic> json) {
    return User(
      userIdx: json['user_idx'],
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
