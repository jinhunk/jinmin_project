import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jinmin_project/url.dart';
import 'package:http/http.dart' as http;
import 'package:jinmin_project/vo/user.dart';

class UserModel with ChangeNotifier {
  late User me;
  late List<User> allUserList;
  late List<User> allUserName;

  Future<bool> insertUser(
    String userId,
    String userPw,
    String userName,
    int userGender,
    int userBorn,
    String userIntro,
    String userAddress,
    String userJob,
    String userProfileUrl,
  ) async {
    var request = '$serverUrl/insertUser';
    Uri uri = Uri.parse(request);
    var urlWithParam = uri.replace(queryParameters: {
      'user_id': userId,
      'user_pw': userPw,
      'user_name': userName,
      'user_gender': userGender.toString(),
      'user_born': userBorn.toString(),
      'user_intro': userIntro,
      'user_address': userAddress,
      'user_job': userJob,
      'user_profile_url': userProfileUrl
    });

    var response = await http.post(urlWithParam);
    if (response.body == 'ok') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getOneUserByLogin(
    String userId,
    String userPw,
  ) async {
    var request = '$serverUrl/getOneUserByLogin';
    Uri uri = Uri.parse(request);
    var urlWithParam = uri.replace(queryParameters: {
      'user_id': userId,
      'user_pw': userPw,
    });

    var response = await http.get(urlWithParam);
    if (response.body.isNotEmpty) {
      var resultUser = jsonDecode(response.body);
      me = User.fromjson(resultUser);
      notifyListeners();
      return true; //로그인성공
    } else {
      return false; // 로그인실패
    }
  }

  Future<bool> getOneUserByUserIdx(
    int userIdx,
  ) async {
    var request = '$serverUrl/getOneUserByUserIdx';
    Uri uri = Uri.parse(request);
    var urlWithParam = uri.replace(queryParameters: {
      'user_idx': userIdx.toString(),
    });

    var response = await http.get(urlWithParam);
    if (response.body.isNotEmpty) {
      var resultUser = jsonDecode(response.body);
      me = User.fromjson(resultUser);
      notifyListeners();
      return true; //로그인성공
    } else {
      return false; // 로그인실패
    }
  }

  Future<bool> registerCheck(
    String userId,
  ) async {
    var request = '$serverUrl/registerCheck';
    Uri uri = Uri.parse(request);
    var urlWithParam = uri.replace(
      queryParameters: {
        'user_id': userId,
      },
    );

    var response = await http.get(urlWithParam);
    if (response.body == "ok") {
      return true; //로그인성공
    } else {
      return false; // 로그인실패
    }
  }

  void getAllUsers() async {
    allUserList = [];
    var requestUrl = '$serverUrl/getAllUsers';
    Uri uri = Uri.parse(requestUrl);
    var respons = await http.get(uri);
    var list = jsonDecode(respons.body);

    for (int i = 0; i < list.length; i++) {
      User user = User.fromjson(list[i]);
      allUserList.add(user);
    }
    notifyListeners();
  }

  Future<bool> getAllUserByName(String userName) async {
    allUserName = [];
    var requestUrl = '$serverUrl/getAllUserByName';
    Uri uri = Uri.parse(requestUrl);
    var urlWithParam = uri.replace(
      queryParameters: {
        'user_name': userName,
      },
    );

    var response = await http.get(urlWithParam);

    List list = jsonDecode(response.body);

    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        User user = User.fromjson(list[i]);
        allUserName.add(user);
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> userProfileImage(
    int userIdx,
    String userProfileUrl,
  ) async {
    var request = '$serverUrl/userProfileImage';
    Uri uri = Uri.parse(request);
    var urlWithParam = uri.replace(queryParameters: {
      'user_idx': userIdx.toString(),
      'user_profile_url': userProfileUrl
    });

    var response = await http.post(urlWithParam);
    if (response.body == 'ok') {
      return true;
    } else {
      return false;
    }
  }
}
