import 'package:flutter/material.dart';
import 'package:jinmin_project/main_screen/profile_screen/profile_screen.dart';
import 'package:jinmin_project/model/friend_ship.dart';
import 'package:jinmin_project/model/meetingfeed.dart';
import 'package:jinmin_project/model/user_model.dart';
import 'package:jinmin_project/vo/FriendShip.dart';
import 'package:jinmin_project/vo/FriendShipAndUser.dart';
import 'package:jinmin_project/vo/MeetingFeedAndUser.dart';
import 'package:jinmin_project/vo/meetingFeed.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final MeetingFeedAndUser feedAndUser;

  const Profile({
    Key? key,
    required this.feedAndUser,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool friendShipExist = false;

  // void _asyncMethod() async {
  //   bool result = await Provider.of<MeetingFeedModel>(context, listen: false)
  //       .getOneFeedAndUserIdx(widget.feedAndUser.userIdx); // 내림차순
  //   setState(() {
  //     friendShipExist = result;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _asyncMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.feedAndUser.userProfileUrl.length > 10
                  ? Container(
                      width: MediaQuery.of(context).size.width / 1.0,
                      height: 400,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              NetworkImage(widget.feedAndUser.userProfileUrl),
                        ),
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Text(
                      widget.feedAndUser.userName,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      ', ',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.feedAndUser.userName,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Text(
                  widget.feedAndUser.userAddress,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Text(
                  widget.feedAndUser.userBorn.toString(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                color: const Color.fromARGB(255, 220, 220, 220),
                height: 1,
                width: MediaQuery.of(context).size.width / 1.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13, top: 20),
                child: Row(
                  children: [
                    const Text('소개'),
                    const SizedBox(
                      width: 50,
                    ),
                    Text(
                      widget.feedAndUser.userIntro,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Row(
                  children: [
                    const Text('직업'),
                    const SizedBox(
                      width: 50,
                    ),
                    Text(
                      widget.feedAndUser.userJob,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 120,
        child: Column(
          children: [
            // _bottomNavigationBar('괜찮아요'),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                bool Result =
                    await Provider.of<FriendShipModel>(context, listen: false)
                        .insertFriendShip(
                            Provider.of<UserModel>(context, listen: false)
                                .me
                                .userIdx,
                            widget.feedAndUser.userIdx);
                if (Result) {
                  //친구요청하면
                  bool friendResult =
                      await Provider.of<FriendShipModel>(context, listen: false)
                          .getAllFriendShipYetAllow(
                    widget.feedAndUser.userIdx,
                  );
                  if (friendResult) {}
                  setState(() {
                    friendShipExist = friendResult;
                  });
                  Navigator.pop(context);
                } else {
                  print('네트워크 오류');
                }
              },
              child: _bottomNavigationBar('친구 요청'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _bottomNavigationBar(
  String title,
) {
  return Container(
    height: 50,
    width: 360,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.teal[300],
    ),
    child: Center(
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
      ),
    ),
  );
}
