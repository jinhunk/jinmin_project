import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jinmin_project/vo/FeedComment.dart';
import 'package:jinmin_project/vo/FeedCommentAndUser.dart';

import '../url.dart';

class FeedCommentModel with ChangeNotifier {
  late List<FeedCommentAndUser> feedAllUserComment;
  late FeedComment fc;

  Future<bool> insertFeedComment(
      int meetingFeedIdx, String commentContent, int userIdx) async {
    var request = '$serverUrl/insertFeedComment';
    Uri uri = Uri.parse(request);
    var urlWithParam = uri.replace(
      queryParameters: {
        'meeting_feed_idx': meetingFeedIdx.toString(),
        'user_idx': userIdx.toString(),
        'comment_content': commentContent,
      },
    );
    var response = await http.post(urlWithParam);
    if (response.body == 'ok') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getAllCommentUserFeedIdx(int meetingFeedIdx) async {
    feedAllUserComment = [];
    var requestUrl = '$serverUrl/getAllCommentUserFeedIdx';
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
        FeedCommentAndUser F = FeedCommentAndUser.fromJson(list[i]);
        feedAllUserComment.add(F);
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteFeedComment(int feedCommentIdx) async {
    var request = '$serverUrl/deleteFeedComment';
    Uri uri = Uri.parse(request);
    var urlWithParam = uri.replace(
      queryParameters: {
        'feed_comment_idx': feedCommentIdx.toString(),
      },
    );
    var response = await http.post(urlWithParam);
    if (response.body == 'ok') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getOneFeedCommentIdx(
    int feedCommentIdx,
  ) async {
    var request = '$serverUrl/getOneFeedCommentIdx';
    Uri uri = Uri.parse(request);
    var urlWithParam = uri.replace(queryParameters: {
      'feed_comment_idx': feedCommentIdx.toString(),
    });

    var response = await http.get(urlWithParam);
    if (response.body.isNotEmpty) {
      var resultComment = jsonDecode(response.body);
      fc = FeedComment.fromjson(resultComment);
      notifyListeners();
      return true; //로그인성공
    } else {
      return false; // 로그인실패
    }
  }
}
