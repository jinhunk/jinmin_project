import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jinmin_project/first_screen.dart';
import 'package:jinmin_project/model/feed_comment.dart';
import 'package:jinmin_project/model/feed_like_model.dart';
import 'package:jinmin_project/model/friend_ship.dart';
import 'package:jinmin_project/model/meetingfeed.dart';

import 'package:jinmin_project/model/user_model.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => MeetingFeedModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => FeedLikeModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => FeedCommentModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => FriendShipModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const FirstScreen(), //로그인전 자동로그인 여부페이지
      ),
    );
  }
}
