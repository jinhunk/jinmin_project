import 'package:flutter/material.dart';
import 'package:jinmin_project/model/feed_comment.dart';
import 'package:jinmin_project/model/meetingfeed.dart';

import 'package:jinmin_project/model/user_model.dart';
import 'package:jinmin_project/vo/FeedCommentAndUser.dart';
import 'package:jinmin_project/vo/MeetingFeedAndUser.dart';
import 'package:provider/provider.dart';

import '../vo/meetingFeed.dart';

class CommentScreen extends StatefulWidget {
  late MeetingFeedAndUser feedAndUser;

  CommentScreen({
    Key? key,
    required this.feedAndUser,
  }) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  bool commentExist = false;

  bool commentImage = false;

  final _controller = TextEditingController();

  String message = '';

  void _asyncMethod() async {
    bool result = await Provider.of<FeedCommentModel>(context, listen: false)
        .getAllCommentUserFeedIdx(widget.feedAndUser.meetingIdx); // 내림차순
    setState(() {
      commentExist = result;
    });
  }

  void _asyncMethod2() async {
    bool result = await Provider.of<UserModel>(context, listen: false)
        .userProfileImage(
            widget.feedAndUser.userIdx, widget.feedAndUser.userProfileUrl);
    commentImage = result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _asyncMethod();
    _asyncMethod2();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('댓글'),
          backgroundColor: Colors.indigo,
          elevation: 0.0,
        ),
        bottomSheet: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              width: double.infinity,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.black),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 13.0),
                  child: Row(
                    children: [
                      Consumer<UserModel>(
                        builder: (context, userModel, child) {
                          return CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                                userModel.me.userProfileUrl,
                                scale: 1.0),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: '댓글 달기 ...',
                                  hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                  border: InputBorder.none,
                                ),
                                controller: _controller,
                                onChanged: (value) {
                                  setState(() {
                                    message = value;
                                  });
                                },
                              ),
                            ),
                            Positioned(
                              left: 250,
                              top: 10,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 10.0,
                                height: 30,
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (message.isNotEmpty) {
                                        bool result = await Provider.of<
                                                    FeedCommentModel>(context,
                                                listen: false)
                                            .insertFeedComment(
                                                widget.feedAndUser.meetingIdx,
                                                message,
                                                Provider.of<UserModel>(context,
                                                        listen: false)
                                                    .me
                                                    .userIdx);
                                        if (result) {
                                          //게시 성공
                                          bool commentResult = await Provider
                                                  .of<FeedCommentModel>(context,
                                                      listen: false)
                                              .getAllCommentUserFeedIdx(widget
                                                  .feedAndUser.meetingIdx);
                                          setState(() {
                                            commentExist = commentResult;
                                          });
                                          _controller.clear();
                                        } else {
                                          print('네트워크 오류');
                                        }
                                      }
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: Text(
                                      '게시',
                                      style: TextStyle(
                                        color: message.length > 1
                                            ? Colors.lightBlueAccent
                                            : Colors.blue.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.feedAndUser.userProfileUrl.length > 10
                          ? CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  widget.feedAndUser.userProfileUrl),
                            )
                          : const CircleAvatar(
                              backgroundImage: NetworkImage(''),
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Text(
                              widget.feedAndUser.userName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(widget.feedAndUser.content),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              commentExist
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 200,
                      child: Consumer<FeedCommentModel>(
                        builder: (context, feedCommentModel, child) {
                          return SingleChildScrollView(
                            child: Column(
                                children: feedCommentModel.feedAllUserComment
                                    .map((meeting) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 13),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                            meeting.userProfileUrl),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        meeting.userName,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(meeting.commentContent),
                                    ],
                                  ),
                                ),
                              );
                            }).toList()),
                          );
                        },
                      ),
                    )
                  : const Text('작성된 댓글이 없습니다.'),
            ],
          ),
        ),
      ),
    );
  }
}
