import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:jinmin_project/main_screen.dart';
import 'package:jinmin_project/model/user_model.dart';
import 'package:jinmin_project/screen/sign_up_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controlleremail = TextEditingController();
  TextEditingController _controllerpassword = TextEditingController();
  String userId = '';
  String userPw = '';

  void _login() {
    final isValid2 = _formKey.currentState!.validate();
    if (isValid2) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: TextFormField(
                  controller: _controlleremail,
                  decoration: const InputDecoration(
                      hintText: '아이디',
                      helperText: "이메일형식@gmail.com",
                      hintStyle: TextStyle(fontSize: 13.0)),
                  onChanged: ((value) {
                    setState(() {
                      userId = value;
                    });
                  }),
                  validator: (email) {
                    if (email!.isEmpty) {
                      return '이메일을 입력해주세요.';
                    } else {
                      return EmailValidator.validate(email) == email.isEmpty
                          ? "공백없이 올바른 이메일 형식 또는 아이디를 입력해주세요."
                          : null;
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                controller: _controllerpassword,
                decoration: const InputDecoration(
                    hintText: '비밀번호',
                    helperText: '영문, 숫자, 특수문자 포함 최소 6자입니다',
                    hintStyle: TextStyle(fontSize: 13.0)),
                onChanged: ((value) {
                  setState(() {
                    userPw = value;
                  });
                }),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "비밀번호를 입력해주세용용.";
                  } else {
                    return value.length > 5
                        ? null
                        : "비밀번호는 영문, 숫자, 특수문자 포함 최소 6자입니다";
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 240, 227, 243),
                      ),
                      width: MediaQuery.of(context).size.width / 5.5,
                      height: 35,
                      child: const Center(
                        child: Text(
                          '회원가입',
                          style: TextStyle(color: Colors.purple),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                  ),
                  const SizedBox(
                    width: 95,
                  ),
                  const Text('아이디 찾기 '),
                  const Text('ㅣ'),
                  const Text(' 비밀번호 찾기'),
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 209, 206, 206)),
                width: MediaQuery.of(context).size.width / 1.2,
                height: 50,
                child: const Center(
                  child: Text(
                    '로그인',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onTap: () async {
                if (userId.isNotEmpty && userPw.isNotEmpty) {
                  bool loginResult =
                      await Provider.of<UserModel>(context, listen: false)
                          .getOneUserByLogin(userId, userPw);
                  if (loginResult) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isLogin', true); //로그인
                    await prefs.setInt(
                        'loggedUserIdx',
                        Provider.of<UserModel>(context, listen: false)
                            .me
                            .userIdx);
                    //자동 로그인

                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const MainScreen(),
                      ),
                    );
                    print('성공');

                    //로그인 되고 메인스크린으로

                  } else {
                    print('실패');
                    //에러
                  }
                }
                setState(() {
                  _login();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
