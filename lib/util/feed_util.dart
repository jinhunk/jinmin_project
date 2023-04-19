import 'package:flutter/material.dart';
import 'package:jinmin_project/home_screen/profile_screen.dart';
import 'package:jinmin_project/main_screen/comment_screen.dart';
import 'package:jinmin_project/model/feed_like_model.dart';
import 'package:jinmin_project/model/meetingfeed.dart';
import 'package:jinmin_project/model/user_model.dart';
import 'package:jinmin_project/vo/FriendShipAndUser.dart';
import 'package:jinmin_project/vo/MeetingFeedAndUser.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class FeedUtil extends StatefulWidget {
  final MeetingFeedAndUser feedAndUser;

  const FeedUtil({
    Key? key,
    required this.feedAndUser,
  }) : super(key: key);

  @override
  _FeedUtilState createState() => _FeedUtilState();
}

class _FeedUtilState extends State<FeedUtil> {
  bool _load = false;
  // 내가 좋아요을 눌렀는지
  bool favoriteCheck = false;

  void _ayncMethod() async {
    setState(() {
      _load = true;
    });
    bool favoriteResult =
        await Provider.of<FeedLikeModel>(context, listen: false).favoriteCheck(
            widget.feedAndUser.meetingIdx,
            Provider.of<UserModel>(context, listen: false).me.userIdx);
    setState(() {
      favoriteCheck = favoriteResult;
      _load = false;
    });
  } //좋아요 체크(하트)

  @override
  void initState() {
    super.initState();

    _ayncMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 450,
      child: LoadingOverlay(
        isLoading: _load,
        opacity: 0.5,
        child: Column(
          children: [
            Stack(
              children: [
                widget.feedAndUser.imageUrl1.length > 10
                    ? Container(
                        width: MediaQuery.of(context).size.width / 1.0,
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.feedAndUser.imageUrl1),
                          ),
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width / 1.0,
                        height: 300,
                        color: Colors.amber,
                        child: Center(
                          child: Text(
                            widget.feedAndUser.content,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                Positioned(
                  left: 355,
                  top: 10,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 16.0,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink),
                    child: const Center(
                      child: Text(
                        'N',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  widget.feedAndUser.userProfileUrl.length > 10
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => Profile(
                                  feedAndUser: widget.feedAndUser,
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.feedAndUser.userProfileUrl),
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.feedAndUser.userName,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(widget.feedAndUser.content),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('${widget.feedAndUser.favoriteCount} 명이 좋아요를 눌렀습니다'),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () async {
                    //하트삭제
                    if (favoriteCheck) {
                      bool result = await Provider.of<FeedLikeModel>(context,
                              listen: false)
                          .deleteFeedLike(
                              widget.feedAndUser.meetingIdx,
                              Provider.of<UserModel>(context, listen: false)
                                  .me
                                  .userIdx);
                      if (result = true) {
                        //하트삭제성공
                        bool countResult = await Provider.of<MeetingFeedModel>(
                                context,
                                listen: false)
                            .downFavoriteCount(widget.feedAndUser.meetingIdx);
                        _ayncMethod();
                      } else {
                        print('네트워크 오류');
                        //하트삭제실패
                      }
                      //하트생성
                    } else {
                      bool result = await Provider.of<FeedLikeModel>(context,
                              listen: false)
                          .insertFeedLike(
                              widget.feedAndUser.meetingIdx,
                              Provider.of<UserModel>(context, listen: false)
                                  .me
                                  .userIdx);
                      if (result) {
                        //좋아요성공
                        bool countResult = await Provider.of<MeetingFeedModel>(
                                context,
                                listen: false)
                            .upFavoriteCount(widget.feedAndUser.meetingIdx);
                        _ayncMethod();
                      } else {
                        print('좋아요실패');
                      }
                    } //하트삭제
                  },
                  child: Icon(
                    favoriteCheck ? Icons.favorite : Icons.favorite_border,
                    color: favoriteCheck ? Colors.pink : Colors.grey,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            CommentScreen(feedAndUser: widget.feedAndUser),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.chat_bubble_outline,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
