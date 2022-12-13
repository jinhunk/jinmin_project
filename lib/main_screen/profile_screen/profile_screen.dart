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

  Widget _bodytop() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40.0, top: 30.0),
          child: Column(
            children: [
              GestureDetector(
                child: Row(
                  children: const [
                    Icon(Icons.mic),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text('목소리 등록'),
                  ],
                ),
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => const Voice()),
                //   );
                // },
              ),
              const SizedBox(
                height: 5.0,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                width: MediaQuery.of(context).size.width / 2.9,
                height: MediaQuery.of(context).size.height / 600.5,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 236, 236, 236),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13.0),
                child: GestureDetector(
                  child: Row(
                    children: const [
                      Icon(Icons.pets),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text('반려동물 등록'),
                    ],
                  ),
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => const Animal()),
                  //   );
                  // },
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                width: MediaQuery.of(context).size.width / 2.9,
                height: MediaQuery.of(context).size.height / 600.5,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 236, 236, 236),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: GestureDetector(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.check_circle,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text('프로필 인증'),
                    ],
                  ),
                  // onTap: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) =>
                  //               const profilecertification()));
                  // },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bodybottom() {
    return Column(
      children: [
        const Text(
          '프로필 평가 전',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 15.0,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.1,
          height: MediaQuery.of(context).size.height / 35.6,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 17.0),
              child: Text(
                '0점',
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            Text(
              '5점',
              style: TextStyle(fontSize: 12.0),
            ),
            Padding(
              padding: EdgeInsets.only(right: 17.0),
              child: Text(
                '10점',
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.1,
          height: MediaQuery.of(context).size.height / 5.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: const Color.fromARGB(255, 209, 208, 208),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      '인기도',
                      style: TextStyle(fontSize: 17.0),
                    ),
                    Text(
                      '프로필 관심도',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 13.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    '0%',
                    style: TextStyle(
                      fontSize: 35.0,
                      color: Color.fromARGB(255, 25, 163, 30),
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: MediaQuery.of(context).size.width / 500.1,
                    height: MediaQuery.of(context).size.height / 30.6,
                  ),
                  const Text(
                    '0%',
                    style: TextStyle(
                      fontSize: 35.0,
                      color: Color.fromARGB(255, 243, 223, 43),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    '친구가 날 좋아할 확률입니다.',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color.fromARGB(255, 180, 178, 178),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    '내 프로필을 열어볼 확률입니다.',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color.fromARGB(255, 180, 178, 178),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bodybottombutton() {
    return Column(
      children: [
        GestureDetector(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 18.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.pink),
              child: const Text(
                '내 프로필 평가받기',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              )),
          onTap: () {
            _bodybottombuttonalert(context);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Consumer<UserModel>(
          builder: (context, userModel, child) {
            return Text(
              userModel.me.userName,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            );
          },
        ),
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: LoadingOverlay(
          isLoading: _load,
          opacity: 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Row(
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
                          backgroundImage:
                              NetworkImage(userModel.me.userProfileUrl),
                        );
                      },
                    ),
                    _bodytop(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Container(
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
              ),
              const SizedBox(
                height: 70,
              ),
              _bodybottom(),
              const SizedBox(
                height: 50,
              ),
              Center(child: _bodybottombutton())
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _bodybottombuttonalert(BuildContext context) async {
  return showDialog<void>(
    //다이얼로그 위젯 소환
    context: context,
    barrierDismissible: false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                children: const [
                  Text(
                    '프로필 평가를 시작할까요?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    '짧은 시간동안 많은 친구들에게 ',
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    '당신이 소개됩니다.',
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 16.0),
                  ),
                ],
              ),
            ),
            content: Column(
              children: const [
                Text(
                  '무료 : 1회',
                  style: TextStyle(color: Colors.pink),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(bottom: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3.2,
                        height: MediaQuery.of(context).size.height / 18.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: Text(
                            '아니요',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.grey, fontSize: 18.0),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3.2,
                        height: MediaQuery.of(context).size.height / 18.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.pink),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: Text(
                            '네',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.pink, fontSize: 18.0),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
