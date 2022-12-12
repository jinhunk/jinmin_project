class FriendShip {
  int friendShipIdx;
  int fromUserIdx; //신청자
  int toUserIdx; //신청받은사람
  int alloW; //신청받은사람이 허락했는지? 0이면 허락x 1이면 허락o

  FriendShip(
      {required this.friendShipIdx,
      required this.fromUserIdx,
      required this.toUserIdx,
      required this.alloW});

  factory FriendShip.fromJson(Map<String, dynamic> json) {
    return FriendShip(
      friendShipIdx: json['friend_ship_idx'],
      fromUserIdx: json['from_user_idx'],
      toUserIdx: json['to_user_idx'],
      alloW: json['allow'],
    );
  }
}
