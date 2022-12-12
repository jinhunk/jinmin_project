import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jinmin_project/main_screen.dart';
import 'package:jinmin_project/model/user_model.dart';
import 'package:jinmin_project/screen/authorlty_screen.dart';
import 'package:jinmin_project/screen/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  void checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final int? loggedUserIdx = prefs.getInt('loggedUserIdx'); // 0,userIdx,null
    final bool? isLogin = prefs.getBool('isLogin'); //false,true,null
    if (isLogin != null) {
      if (isLogin) {
        bool autoLoginResult =
            // ignore: use_build_context_synchronously
            await Provider.of<UserModel>(context, listen: false)
                .getOneUserByUserIdx(loggedUserIdx!);

        if (autoLoginResult) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const MainScreen(),
            ),
          );
          //자동로그인 가능

        } else {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
        //로그인이 된 상태
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const LoginScreen(),
          ),
        );

        //로그인이 안된 상태
      }
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (context) => const LoginScreen(),
        ),
      );
      //로그인 페이지로 이동
    }
  }

  void checkLoaction() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      //거절
      if (permission == LocationPermission.denied) {
        //100프로거절
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const Authorlty(),
          ),
        );
      } else if (permission == LocationPermission.deniedForever) {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const Authorlty(),
          ),
        );
      } else {
        checkLogin();
        //허용
      }
    } else if (permission == LocationPermission.deniedForever) {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (context) => const Authorlty(),
        ),
      );
      //영원히거절
    } else {
      checkLogin();
      //허용
    }
  }

  // void checkCamera(){
  //  if(거절이면){
  //   권한 물어봄
  //   if(한번더 거절하면){
  //    설정화면

  //   }else if(영원히 거절){
  //     설정화면
  //   }else{
  //     checkLogin();
  //   }

  //  }else if(영원히 거절){
  //    설정화면
  //  }else{
  //    checkLogin();
  //  }
  // }

  @override
  void initState() {
    super.initState();
    checkLoaction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
