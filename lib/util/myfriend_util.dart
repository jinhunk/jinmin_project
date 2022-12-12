import 'package:flutter/material.dart';
import 'package:jinmin_project/vo/FriendShipAndUser.dart';

class MyfriendUtil extends StatefulWidget {
  late FriendShipAndUser friendShipAndUser;
  MyfriendUtil({Key? key, required this.friendShipAndUser}) : super(key: key);

  @override
  _MyfriendUtilState createState() => _MyfriendUtilState();
}

class _MyfriendUtilState extends State<MyfriendUtil> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 20),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
