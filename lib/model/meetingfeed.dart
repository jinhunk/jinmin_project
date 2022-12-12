import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jinmin_project/url.dart';
import 'package:http/http.dart' as http;
import 'package:jinmin_project/vo/MeetingFeedAndUser.dart';
import 'package:jinmin_project/vo/meetingFeed.dart';

class MeetingFeedModel with ChangeNotifier {
  late MeetingFeed getFeed;
  late MeetingFeedAndUser getFeedUser;
  late List<MeetingFeedAndUser> feedAllUserList;
  late List<MeetingFeedAndUser> feedAllCityList;
  late List<MeetingFeedAndUser> feedAllContentList;
  late List<MeetingFeedAndUser> feedAllCityListForHome;

  Future<bool> insertMeetingFeed(
      int userIdx,
      String placeCity,
      String title,
      String content,
      double placeLat,
      double placeLon,
      String imageUrl1,
      String imageUrl2,
      String imageUrl3) async {
    var request = '$serverUrl/insertMeetingFeed';
    Uri uri = Uri.parse(request);
    var urlWithParam = uri.replace(
      queryParameters: {
        'user_idx': userIdx.toString(),
        'place_city': placeCity,
        'title': title,
        'content': content,
        'place_lat': placeLat.toString(),
        'place_lon': placeLon.toString(),
        'image_url1': imageUrl1,
        'image_url2': imageUrl2,
        'image_url3': imageUrl3
      },
    );
    var response = await http.post(urlWithParam);
    if (response.body == 'ok') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getAllFeedByUserIdx(int userIdx) async {
    feedAllUserList = [];
    var requestUrl = '$serverUrl/getAllFeedByUserIdx';
    Uri uri = Uri.parse(requestUrl);
    var urlWithParam = uri.replace(
      queryParameters: {
        'user_idx': userIdx.toString(),
      },
    );

    var response = await http.get(urlWithParam);

    List list = jsonDecode(response.body);

    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        MeetingFeedAndUser b = MeetingFeedAndUser.fromjson(list[i]);
        feedAllUserList.add(b);
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  //인기순으로
  Future<bool> getAllFeedByCity(String placeCtiy) async {
    feedAllCityList = [];
    var requestUrl = '$serverUrl/getAllFeedByCity';
    Uri uri = Uri.parse(requestUrl);
    var urlWithParam = uri.replace(
      queryParameters: {
        'place_city': placeCtiy,
      },
    );

    var response = await http.get(urlWithParam);

    List list = jsonDecode(response.body);

    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        MeetingFeedAndUser b = MeetingFeedAndUser.fromjson(list[i]);
        feedAllCityList.add(b);
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

//최신순으로
  Future<bool> getAllFeedByCityForHome(String placeCtiy) async {
    feedAllCityListForHome = [];
    var requestUrl = '$serverUrl/getAllFeedByCityForHome';
    Uri uri = Uri.parse(requestUrl);
    var urlWithParam = uri.replace(
      queryParameters: {
        'place_city': placeCtiy,
      },
    );

    var response = await http.get(urlWithParam);

    List list = jsonDecode(response.body);

    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        MeetingFeedAndUser b = MeetingFeedAndUser.fromjson(list[i]);
        feedAllCityListForHome.add(b);
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getAllFeedByContent(String content) async {
    feedAllContentList = [];
    var requestUrl = '$serverUrl/getAllFeedByContent';
    Uri uri = Uri.parse(requestUrl);
    var urlWithParam = uri.replace(
      queryParameters: {
        'content': content,
      },
    );

    var response = await http.get(urlWithParam);

    List list = jsonDecode(response.body);

    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        MeetingFeedAndUser b = MeetingFeedAndUser.fromjson(list[i]);
        feedAllContentList.add(b);
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getOneFeedByMeetingFeedIdx(int meetingIdx) async {
    var requestUrl = '$serverUrl/getOneFeedByMeetingFeedIdx';
    Uri uri = Uri.parse(requestUrl);
    var urlWithParam = uri.replace(
      queryParameters: {
        'meeting_idx': meetingIdx.toString(),
      },
    );
    var response = await http.get(urlWithParam);

    if (response.body.isNotEmpty) {
      var result = jsonDecode(response.body);
      getFeed = MeetingFeed.fromjson(result);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getOneFeedAndUserIdx(int meetingIdx) async {
    var requestUrl = '$serverUrl/getOneFeedAndUserIdx';
    Uri uri = Uri.parse(requestUrl);
    var urlWithParam = uri.replace(
      queryParameters: {
        'meeting_idx': meetingIdx.toString(),
      },
    );
    var response = await http.get(urlWithParam);

    if (response.body.isNotEmpty) {
      var result = jsonDecode(response.body);
      getFeedUser = MeetingFeedAndUser.fromjson(result);

      //getFeedUser변수로 이 정보들을 다 담음
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  // 내가 피드에 반응을 남겼을 떄
  //하트 숫자 올라감
  Future<bool> upFavoriteCount(int meetingIdx) async {
    var requestUrl = '$serverUrl/upFavoriteCount';
    Uri uri = Uri.parse(requestUrl);
    var urlWithParam = uri.replace(
      queryParameters: {
        'meeting_idx': meetingIdx.toString(),
      },
    );

    var response = await http.get(urlWithParam);

    if (response.body == 'ok') {
      return true;
    } else {
      return false;
    }
  }

  //하트 숫자 내려감
  Future<bool> downFavoriteCount(int meetingIdx) async {
    var requestUrl = '$serverUrl/downFavoriteCount';
    Uri uri = Uri.parse(requestUrl);
    var urlWithParam = uri.replace(
      queryParameters: {
        'meeting_idx': meetingIdx.toString(),
      },
    );

    var response = await http.get(urlWithParam);

    if (response.body == 'ok') {
      return true;
    } else {
      return false;
    }
  }
}
