import 'package:flutter/material.dart';
import 'package:jinmin_project/friend_screen/my_friend.dart';
import 'package:jinmin_project/model/friend_ship.dart';
import 'package:jinmin_project/model/user_model.dart';
import 'package:jinmin_project/vo/FriendShipAndUser.dart';
import 'package:provider/provider.dart';

class FriendUtil extends StatefulWidget {
  late FriendShipAndUser friendShipAndUser;
  FriendUtil({Key? key, required this.friendShipAndUser}) : super(key: key);

  @override
  _FriendUtilState createState() => _FriendUtilState();
}

class _FriendUtilState extends State<FriendUtil> {
  bool friendShip = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage:
                NetworkImage(widget.friendShipAndUser.userProfileUrl),
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  widget.friendShipAndUser.userName,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: ElevatedButton(
                      onPressed: () async {
                        bool result = await Provider.of<FriendShipModel>(
                                context,
                                listen: false)
                            .allowFriendShip(
                                widget.friendShipAndUser.friendShipIdx);
                        if (result) {
                          bool Shipresult = await Provider.of<FriendShipModel>(
                                  context,
                                  listen: false)
                              .getAllUserFriendShip(
                                  Provider.of<UserModel>(context, listen: false)
                                      .me
                                      .userIdx);
                        }
                      },
                      child: const Text('확인'),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 201, 197, 197)),
                      onPressed: () async {
                        bool result = await Provider.of<FriendShipModel>(
                                context,
                                listen: false)
                            .deleteFriendShip(
                                widget.friendShipAndUser.friendShipIdx);
                      },
                      child: const Text(
                        '삭제',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }
}
