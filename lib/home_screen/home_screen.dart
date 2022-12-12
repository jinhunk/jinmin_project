import 'package:flutter/material.dart';

import 'package:jinmin_project/model/meetingfeed.dart';
import 'package:jinmin_project/model/user_model.dart';
import 'package:jinmin_project/screen/login_screen.dart';
import 'package:jinmin_project/util/feed_util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    Provider.of<MeetingFeedModel>(context, listen: false)
        .getAllFeedByCityForHome(
            Provider.of<UserModel>(context, listen: false).me.userAddress);
  }

  // 추천
  Widget SuggestionPages() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 300.0),
            child: Text(
              '오늘의 추천',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Consumer<MeetingFeedModel>(
              builder: (context, meetingFeedMoel, child) {
            return Column(
              children: meetingFeedMoel.feedAllCityListForHome.map((meeting) {
                return FeedUtil(feedAndUser: meeting);
              }).toList(),
            );
          })
        ],
      ),
    );
  }

//라운지
  Widget loungebody() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        backgroundColor: Colors.white,
        elevation: 0.0,
        leadingWidth: 130,
        leading: Column(
          children: [
            TabBar(
              padding: const EdgeInsets.only(left: 5.0),
              labelPadding: const EdgeInsets.symmetric(
                horizontal: 0.0,
              ),
              // isScrollable: true,
              labelColor: Colors.black,
              controller: _tabController,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 2,
              tabs: const [
                Tab(
                  child: Text(
                    '추천',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    '라운지',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
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
      body: TabBarView(
        controller: _tabController,
        children: [
          SuggestionPages(),
          loungebody(),
        ],
      ),
    );
  }
}
