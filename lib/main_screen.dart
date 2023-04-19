import 'package:flutter/material.dart';
import 'package:jinmin_project/friend_screen/friend_screen.dart';
import 'package:jinmin_project/home_screen/home_screen.dart';
import 'package:jinmin_project/main_screen/profile_screen/profile_screen.dart';
import 'package:jinmin_project/main_screen/story_screen.dart';
import 'package:jinmin_project/main_screen/woman_screen.dart';
import 'package:jinmin_project/model/meetingfeed.dart';
import 'package:jinmin_project/model/user_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // 선택된 페이지의 인덱스 넘버 초기화
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold); // 텍스트 스타일 지정이므로 해당 부분은 제거해도 된다.

  void _onItemTapped(int index) {
    // 탭을 클릭했을떄 지정한 페이지로 이동
    setState(() {
      _selectedIndex = index;
    });
  }

  void firstMethod() {
    int userGender =
        Provider.of<UserModel>(context, listen: false).me.userGender;
    if (userGender == 0) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const WomanScreen(),
          ),
        );
      });
    }
  }

  // void asyncmehod() {
  //   Provider.of<UserModel>(context, listen: false).userProfileImage(
  //       Provider.of<UserModel>(context, listen: false).me.userIdx, '');
  // }

  final List _widgetOptions = [
    const HomeScreen(),
    const StoryScreen(),
    FriendScreen(),
    const ProfileScreen(),
  ]; // 3개의 페이지를 연결할 예정이므로 3개의 페이지를 여기서 지정해준다. 탭 레이아웃은 3개.

  @override
  void initState() {
    super.initState();
    firstMethod();
    Provider.of<MeetingFeedModel>(context, listen: false).getAllFeedByCity(
        Provider.of<UserModel>(context, listen: false).me.userAddress);
    // asyncmehod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.white,
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.all(15.0),
      //       child: GestureDetector(
      //         child: const Text(
      //           '로그아웃',
      //           style: TextStyle(color: Colors.black),
      //         ),
      //         onTap: () async {
      //           final prefs = await SharedPreferences.getInstance();
      //           await prefs.setBool('isLogin', false);
      //           await prefs.setInt('loggedUserIdx', 0);

      //           // ignore: use_build_context_synchronously
      //           Navigator.pushReplacement<void, void>(
      //             context,
      //             MaterialPageRoute<void>(
      //               builder: (BuildContext context) => const LoginScreen(),
      //             ),
      //           );
      //         },
      //       ),
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // bottom navigation 선언
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 231, 66, 121),
        unselectedItemColor: const Color.fromARGB(255, 231, 66, 121),

        elevation: 0.0,
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 30,
            ),
            label: '스토리',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_alt),
            label: '친구',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '프로필',
          ),
        ],

        currentIndex: _selectedIndex, // 지정 인덱스로 이동

        onTap: _onItemTapped, // 선언했던 onItemTapped
      ),
    );
  }
}
