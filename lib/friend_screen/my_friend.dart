import 'package:flutter/material.dart';
import 'package:jinmin_project/model/friend_ship.dart';
import 'package:jinmin_project/model/user_model.dart';
import 'package:jinmin_project/util/friend_util.dart';
import 'package:jinmin_project/util/myfriend_util.dart';
import 'package:jinmin_project/vo/FriendShipAndUser.dart';
import 'package:provider/provider.dart';

class MyFriend extends StatefulWidget {
  MyFriend({
    Key? key,
  }) : super(key: key);

  @override
  _MyFriendState createState() => _MyFriendState();
}

class _MyFriendState extends State<MyFriend> {
  bool myFriend = false;
  int? shipCount;

  void _asyncMethod() async {
    bool result = await Provider.of<FriendShipModel>(context, listen: false)
        .getAllUserFriendShip(
            Provider.of<UserModel>(context, listen: false).me.userIdx);
    // 내림차순

    setState(() {
      myFriend = result;
    });
  }

  void _asyncMethod2() async {
    int result = await Provider.of<FriendShipModel>(context, listen: false)
        .countFriendShip(
            Provider.of<UserModel>(context, listen: false).me.userIdx);

    setState(() {
      shipCount = result;
    });

    // 내림차순
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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            '내 친구',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(),
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '친구 ${shipCount.toString()}명',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            myFriend
                ? Consumer<FriendShipModel>(
                    builder: (context, feedCommentModel, child) {
                      return SingleChildScrollView(
                        child: Column(
                            children: feedCommentModel.friendShipAllUser
                                .map((meeting) {
                          return MyfriendUtil(friendShipAndUser: meeting);
                        }).toList()),
                      );
                    },
                  )
                : Container(),
          ],
        ));
  }
}
