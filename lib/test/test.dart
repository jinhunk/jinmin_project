import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:jinmin_project/model/friend_ship.dart';
import 'package:jinmin_project/test/test_two.dart';

import 'package:jinmin_project/vo/FriendShip.dart';
import 'package:provider/provider.dart';

class Test extends StatefulWidget {
  Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: const [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              '로그아웃',
              style: TextStyle(color: Colors.black),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                      "https://s3.orbi.kr/data/file/united2/7559d4b48ce54f7dba55d2006a53851d.png"),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.mic),
                        Text("목소리 등록"),
                      ],
                    ),
                    Container(
                      color: const Color.fromARGB(255, 211, 209, 209),
                      width: 100,
                      height: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Icon(Icons.mic),
                        Text("목소리 등록"),
                      ],
                    ),
                    Container(
                      color: const Color.fromARGB(255, 211, 209, 209),
                      width: 100,
                      height: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Icon(Icons.mic),
                        Text("목소리 등록"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: GestureDetector(
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.amber),
                child: const Center(
                  child: Text(
                    '프로필 수정',
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const TestTwo(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          const Center(
            child: Text(
              "프로필 평가 전",
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              height: 30,
              width: 360,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color.fromARGB(255, 205, 202, 202)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('0점'),
              Text('0점'),
              Text('0점'),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: 360,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          '인기도',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          '프로필 관심도',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          '0%',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          "ㅣ",
                          style: TextStyle(fontSize: 30, color: Colors.grey),
                        ),
                        Text(
                          '0%',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          '친구가 날 좋아할 확률입니다.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '내 프로필을 열어볼 확률입니다.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              height: 50,
              width: 360,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.amber),
              child: const Center(
                child: Text(
                  '내 프로필 평가받기',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
