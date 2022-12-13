import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jinmin_project/friend_screen/my_friend.dart';
import 'package:jinmin_project/model/friend_ship.dart';
import 'package:jinmin_project/model/meetingfeed.dart';
import 'package:jinmin_project/model/user_model.dart';
import 'package:jinmin_project/util/friend_util.dart';
import 'package:jinmin_project/vo/FriendShipAndUser.dart';
import 'package:jinmin_project/vo/MeetingFeedAndUser.dart';
import 'package:provider/provider.dart';

class FriendScreen extends StatefulWidget {
  FriendScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  bool friendShipExist = false;

  void _asyncMethod() async {
    bool result = await Provider.of<FriendShipModel>(context, listen: false)
        .getAllFriendShipYetAllow(
            Provider.of<UserModel>(context, listen: false).me.userIdx); // 내림차순
    setState(() {
      friendShipExist = result;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _asyncMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '친구',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyFriend()));
              },
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 216, 213, 213),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    '내 친구',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Container(
            margin: const EdgeInsets.only(bottom: 6.0),
            width: MediaQuery.of(context).size.width / 1.0,
            height: MediaQuery.of(context).size.height / 500.0,
            color: const Color.fromARGB(255, 248, 245, 245),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '친구 요청',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              friendShipExist
                  ? Consumer<FriendShipModel>(
                      builder: (context, feedCommentModel, child) {
                        return SingleChildScrollView(
                          child: Column(
                              children: feedCommentModel
                                  .friendShipYetAllowAllUser
                                  .map((meeting) {
                            return FriendUtil(friendShipAndUser: meeting);
                          }).toList()),
                        );
                      },
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
