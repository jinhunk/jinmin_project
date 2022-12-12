import 'package:flutter/material.dart';
import 'package:jinmin_project/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WomanScreen extends StatefulWidget {
  const WomanScreen({Key? key}) : super(key: key);

  @override
  _WomanScreenState createState() => _WomanScreenState();
}

class _WomanScreenState extends State<WomanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
    );
  }
}
