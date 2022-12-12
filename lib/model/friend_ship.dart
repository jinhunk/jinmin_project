import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:jinmin_project/url.dart';
import 'package:jinmin_project/vo/FriendShip.dart';
import 'package:jinmin_project/vo/FriendShipAndUser.dart';

class FriendShipModel with ChangeNotifier {
  late FriendShip getFeed;
  late List<FriendShipAndUser> friendShipAllUser;
  late List<FriendShipAndUser> friendShipYetAllowAllUser;
  late FriendShipAndUser getOneShipUser;

  Future<bool> insertFriendShip(
    int fromUserIdx,
    int toUserIdx,
  ) async {
    var request = '$serverUrl/insertFriendShip';
    Uri uri = Uri.parse(request);
    var urlWithParam = uri.replace(
      queryParameters: {
        'from_user_idx': fromUserIdx.toString(),
        'to_user_idx': toUserIdx.toString(),
      },
    );
    var response = await http.post(urlWithParam);
    if (response.body == 'ok') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteFriendShip(int friendShipIdx) async {
    var request = '$serverUrl/deleteFriendShip';
    Uri uri = Uri.parse(request);
    var urlWithParam = uri.replace(
      queryParameters: {
        'friend_ship_idx': friendShipIdx.toString(),
      },
    );
    var response = await http.post(urlWithParam);
    if (response.body == 'ok') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> allowFriendShip(int friendShipIdx) async {
    var request = '$serverUrl/allowFriendShip';
    Uri uri = Uri.parse(request);
    var urlWithParam = uri.replace(
      queryParameters: {
        'friend_ship_idx': friendShipIdx.toString(),
      },
    );
    var response = await http.post(urlWithParam);
    if (response.body == 'ok') {
      return true;
    } else {
      return false;
    }
  }

  //친구요청 보낸자의 정보(내 친구)
  Future<bool> getAllUserFriendShip(int fromUserIdx) async {
    friendShipAllUser = [];
    var requestUrl = '$serverUrl/getAllUserFriendShip';
    Uri uri = Uri.parse(requestUrl);
    var urlWithParam = uri.replace(
      queryParameters: {
        'from_user_idx': fromUserIdx.toString(),
      },
    );

    var response = await http.get(urlWithParam);

    List list = jsonDecode(response.body);

    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        FriendShipAndUser F = FriendShipAndUser.fromjson(list[i]);
        friendShipAllUser.add(F);
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  //받는사람이 친구요청 허용 전
  Future<bool> getAllFriendShipYetAllow(int toUserIdx) async {
    friendShipYetAllowAllUser = [];
    var requestUrl = '$serverUrl/getAllFriendShipYetAllow';
    Uri uri = Uri.parse(requestUrl);
    var urlWithParam = uri.replace(
      queryParameters: {
        'to_user_idx': toUserIdx.toString(),
      },
    );

    var response = await http.get(urlWithParam);

    List list = jsonDecode(response.body);

    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        FriendShipAndUser b = FriendShipAndUser.fromjson(list[i]);
        friendShipYetAllowAllUser.add(b);
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getOneShipAndUserIdx(int friendShipIdx) async {
    var requestUrl = '$serverUrl/getOneShipAndUserIdx';
    Uri uri = Uri.parse(requestUrl);
    var urlWithParam = uri.replace(
      queryParameters: {
        'friend_ship_idx': friendShipIdx.toString(),
      },
    );
    var response = await http.get(urlWithParam);

    if (response.body.isNotEmpty) {
      var result = jsonDecode(response.body);
      getOneShipUser = FriendShipAndUser.fromjson(result);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<int> countFriendShip(int fromUserIdx) async {
    var requestUrl = '$serverUrl/countFriendShip';
    Uri uri = Uri.parse(requestUrl);
    var urlWithParam = uri.replace(
      queryParameters: {
        'from_user_idx': fromUserIdx.toString(),
      },
    );
    var response = await http.get(urlWithParam);
    int countShip = int.parse(response.body.toString());

    return countShip;
  }
}
