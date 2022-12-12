import 'package:flutter/material.dart';
import 'package:jinmin_project/main_screen/write_feed_screen/write_feed_screen.dart';
import 'package:jinmin_project/model/meetingfeed.dart';
import 'package:jinmin_project/model/user_model.dart';
import 'package:jinmin_project/util/feed_util.dart';
import 'package:provider/provider.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  //프로필 이미지
  void userImage() {
    Provider.of<UserModel>(context, listen: false).userProfileImage(
        Provider.of<UserModel>(context, listen: false).me.userIdx,
        Provider.of<UserModel>(context, listen: false).me.userProfileUrl);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MeetingFeedModel>(context, listen: false).getAllFeedByCity(
        Provider.of<UserModel>(context, listen: false).me.userAddress);
    userImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        leadingWidth: 100,
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '스토리',
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: Container(
            margin: EdgeInsets.only(bottom: 6.0),
            width: MediaQuery.of(context).size.width / 1.0,
            height: MediaQuery.of(context).size.height / 500.0,
            color: Color.fromARGB(255, 248, 245, 245),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Row(
                  children: [
                    Consumer<UserModel>(
                      builder: (context, userModel, child) {
                        return CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage(userModel.me.userProfileUrl),
                        );
                      },
                    ),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 75),
                          child: Text(
                            '어떤 친구를 만나고 싶나요?',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const WriteFeedScreen()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.6,
                              height: MediaQuery.of(context).size.height / 19.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: Color.fromARGB(255, 55, 78, 207),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 58.0),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.border_color,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 3.0,
                                    ),
                                    Text(
                                      '스토리 작성하기',
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Consumer<MeetingFeedModel>(
                  builder: (context, meetingFeedModel, child) {
                return Column(
                    children: meetingFeedModel.feedAllCityList.map((meeting) {
                  return FeedUtil(feedAndUser: meeting);
                }).toList());
              }),
            ],
          ),
        ),
      ),
    );
  }
}
