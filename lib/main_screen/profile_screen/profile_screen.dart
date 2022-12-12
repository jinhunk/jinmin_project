import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jinmin_project/main_screen/comment_screen.dart';
import 'package:jinmin_project/main_screen/profile_screen/profileedit_screen.dart';
import 'package:jinmin_project/model/feed_like_model.dart';
import 'package:jinmin_project/model/friend_ship.dart';
import 'package:jinmin_project/model/meetingfeed.dart';
import 'package:jinmin_project/model/user_model.dart';
import 'package:jinmin_project/screen/login_screen.dart';
import 'package:jinmin_project/vo/MeetingFeedAndUser.dart';

import 'package:jinmin_project/vo/meetingFeed.dart';

import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _load = false;

  @override
  void initState() {
    super.initState();
    // Provider.of<UserModel>(context, listen: false).userProfileImage(
    //     Provider.of<UserModel>(context, listen: false).me.userIdx,
    //     Provider.of<UserModel>(context, listen: false).me.userProfileUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              child: const Text(
                '로그아웃',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLogin', false); //로그아웃
                await prefs.setInt('loggedUserIdx', 0);

                // ignore: use_build_context_synchronously
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: LoadingOverlay(
        isLoading: _load,
        opacity: 0.5,
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<UserModel>(
                builder: (context, userModel, child) {
                  if (userModel.me.userProfileUrl.length > 10) {
                    print('10이상');
                  } else {
                    print('이하');
                  }
                  return CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(userModel.me.userProfileUrl),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3.0,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.pink),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const ProfileEditScreen(),
                        ),
                      );
                    },
                    child: const Text('프로필 수정'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
