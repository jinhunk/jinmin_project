import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jinmin_project/vo/FeedLike.dart';
import 'package:jinmin_project/vo/FeedLikeAndUser.dart';
import '../url.dart';

class FeedLikeModel with ChangeNotifier {
  late List<FeedLikeAndUser> feedAllUserLikeList;

  Future<bool> insertFeedLike(int meetingFeedIdx, int userIdx) async {
    var request = '$serverUrl/insertFeedLike';
    Uri uri = Uri.parse(request);
    var urlWithParam = uri.replace(
      queryParameters: {
        'meeting_feed_idx': meetingFeedIdx.toString(),
        'user_idx': userIdx.toString()
      },
    );
    var response = await http.post(urlWithParam);
    if (response.body == 'ok') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getAllUserByFeedIdxToLike(int meetingFeedIdx) async {
    feedAllUserLikeList = [];
    var requestUrl = '$serverUrl/getAllUserByFeedIdxToLike';
    Uri uri = Uri.parse(requestUrl);
    var urlWithParam = uri.replace(
      queryParameters: {
        'meeting_feed_idx': meetingFeedIdx.toString(),
      },
    );

    var response = await http.get(urlWithParam);

    List list = jsonDecode(response.body);

    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        FeedLikeAndUser b = FeedLikeAndUser.fromJson(list[i]);
        feedAllUserLikeList.add(b);
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteFeedLike(int meetingFeedIdx, int userIdx) async {
    var request = '$serverUrl/deleteFeedLike';
    Uri uri = Uri.parse(request);
    var urlWithParam = uri.replace(
      queryParameters: {
        'meeting_feed_idx': meetingFeedIdx.toString(),
        'user_idx': userIdx.toString()
      },
    );
    var response = await http.post(urlWithParam);
    if (response.body == 'ok') {
      return true;
    } else {
      return false;
    }
  }

  Future<int> countFeedLike(int meetingFeedIdx) async {
    var requestUrl = '$serverUrl/countFeedLike';
    Uri uri = Uri.parse(requestUrl);
    var urlWithParam = uri.replace(
      queryParameters: {
        'meeting_feed_idx': meetingFeedIdx.toString(),
      },
    );
    var response = await http.get(urlWithParam);
    int countLike = int.parse(response.body.toString());

    return countLike;
  }

  Future<bool> favoriteCheck(int meetingFeedIdx, int userIdx) async {
    var requestUrl = '$serverUrl/checkFeedLike';
    Uri uri = Uri.parse(requestUrl);
    var urlWithParam = uri.replace(
      queryParameters: {
        'meeting_feed_idx': meetingFeedIdx.toString(),
        'user_idx': userIdx.toString(),
      },
    );

    var response = await http.get(urlWithParam);

    if (response.body == 'yes') {
      return true; // 좋아요를 누른상태
    } else {
      return false; // 반대
    }
  }
}
