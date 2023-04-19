import 'package:flutter/material.dart';
import 'package:jinmin_project/main_screen.dart';
import 'package:jinmin_project/main_screen/woman_screen.dart';
import 'package:jinmin_project/model/user_model.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllereemaill = TextEditingController();
  TextEditingController _controllerpw = TextEditingController();
  TextEditingController _controllername = TextEditingController();
  TextEditingController _controllerborn = TextEditingController();
  TextEditingController _controllerintro = TextEditingController();
  TextEditingController _controllerjob = TextEditingController();

  String id = '';
  String pw = '';
  String name = '';
  String gender = '';
  int born = 10;
  String intro = '';
  String address = '서울';
  String job = '';
  String userprofileurl = '';
  String _man = '남성';
  String _woman = '여성';

  int userGender = 3;

  bool loginUsed = false;
  bool _womanbox = false;
  bool _manbox = false;

  final List<String> _datebirth = ['서울', '경기', '부산'];

  void userIdCheck(String userid) async {
    bool loginCheckResult = await Provider.of<UserModel>(context, listen: false)
        .registerCheck(userid);
    // print(userid.toString());
    setState(() {
      loginUsed = loginCheckResult;
    });
  }

  void genderWoman() {
    gender = _woman;
    if (!_manbox) {
      _womanbox = !_womanbox;
    }
    if (_manbox) {
      _manbox = !_manbox;
    }
    if (!_womanbox) {
      _womanbox = !_womanbox;
    }
  }

  void genderman() {
    gender = _man;
    if (!_womanbox) {
      _manbox = !_manbox;
    }
    if (_womanbox) {
      _womanbox = !_womanbox;
    }
    if (!_manbox) {
      _manbox = !_manbox;
    }
  }

  void singup() {
    final isValid2 = _formKey.currentState!.validate();
    if (isValid2) {
      setState(() {
        _formKey.currentState!.save();
      });
    }
  }

  // ignore: non_constant_identifier_names
  void Loginmanwoman() {
    if (gender == _man) {
      // userGender = 1;
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (context) => const MainScreen(),
        ),
      );
    } else {
      // userGender = 0;
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (context) => const WomanScreen(),
        ),
      );
    }
  }

  Widget Address() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '활동지역',
          style: TextStyle(color: Colors.black),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: DropdownButton(
            value: address,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.amberAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                address = newValue!;
              });
            },
            items: _datebirth.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // void _selectedDate() {
  //   showDatePicker(
  //           context: context,
  //           initialDate: DateTime.now(),
  //           firstDate: DateTime(1990),
  //           lastDate: DateTime.now())
  //       .then((pickedDate) {
  //     if (pickedDate == null) {
  //       return;
  //     }
  //     setState(() {
  //       _controllerborn.text = DateFormat.yMd().format(pickedDate);
  //     });
  //   });
  // }
  //생년월일

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          '회원가입',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Stack(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: '아이디',
                              helperText: "이메일형식@gmail.com",
                              hintStyle: TextStyle(fontSize: 13.0),
                            ),
                            onChanged: (value) {
                              id = value;
                              userIdCheck(value);
                            },
                          ),
                          loginUsed
                              ? const Positioned(
                                  left: 200,
                                  top: 55,
                                  child: Text(
                                    '이미 사용중인 아이디입니다.',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 13),
                                  ),
                                )
                              : const Positioned(
                                  left: 200,
                                  top: 55,
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 0),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width / 1.1,
                //   child: TextFormField(
                //     textInputAction: TextInputAction.next,
                //     controller: _controllereemaill,
                //     decoration: const InputDecoration(
                //       hintText: '아이디',
                //       helperText: "이메일형식@gmail.com",
                //       hintStyle: TextStyle(fontSize: 13.0),
                //     ),
                //     onChanged: ((value) {
                //       userIdCheck(value);
                //       id = value;
                //     }),
                //     validator: (email) {
                //       if (email!.isEmpty) {
                //         return '이메일을 입력해주세요';
                //       } else {
                //         return EmailValidator.validate(email) == email.isEmpty
                //             ? "공백없이 올바른 이메일 형식을 입력해주세요."
                //             : null;
                //       }
                //     },
                //   ),
                // ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _controllerpw,
                    decoration: const InputDecoration(
                        hintText: '비밀번호',
                        helperText: "영문,숫자,특수문자 포함 최소 6자입니다.",
                        hintStyle: TextStyle(fontSize: 13.0)),
                    onChanged: ((value) {
                      setState(() {
                        pw = value;
                      });
                    }),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "비밀번호를 입력해주세요";
                      } else {
                        return value.length > 5
                            ? null
                            : "비밀번호는 영문, 숫자, 특수문자 포함 최소 6자입니다";
                      }
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _controllername,
                    decoration: const InputDecoration(
                        hintText: '닉네임',
                        helperText: "닉네임을 입력해주세요.",
                        hintStyle: TextStyle(fontSize: 13.0)),
                    onChanged: ((value) {
                      setState(() {
                        name = value;
                      });
                    }),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "닉네임을 입력해주세요";
                      } else {
                        return value.length > 2
                            ? null
                            : "닉네임은 영문, 숫자, 한글 포함 최소 3자입니다";
                      }
                    },
                  ),
                ),
                CheckboxListTile(
                  value: _womanbox,
                  onChanged: (value) {
                    _womanbox = value!;
                    setState(() {
                      genderWoman();
                    });
                  },
                  title: const Text('여성'),
                  secondary: const Icon(Icons.pregnant_woman_rounded),
                  selected: _womanbox,
                ),
                CheckboxListTile(
                  value: _manbox,
                  onChanged: (value) {
                    _manbox = value!;
                    setState(() {
                      genderman();
                    });
                  },
                  title: const Text('남성'),
                  secondary: const Icon(Icons.person),
                  selected: _manbox,
                ),

                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    controller: _controllerborn,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: '생년월일',
                      helperText: "생년월일을 입력해주세요. )ex 0/00/0000",
                      hintStyle: TextStyle(fontSize: 13.0),
                    ),
                    onChanged: ((value) {
                      setState(() {
                        born = int.parse(value);
                      });
                    }),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: _controllerintro,
                    decoration: const InputDecoration(
                        hintText: '자기소개',
                        helperText: "자기소개 50자 이내로 입력하세요.",
                        hintStyle: TextStyle(fontSize: 13.0)),
                    onChanged: ((value) {
                      setState(() {
                        intro = value;
                      });
                    }),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "자기소개를 입력해주세요.";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Address(),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextFormField(
                    controller: _controllerjob,
                    decoration: const InputDecoration(
                        hintText: '직업',
                        // helperText: "이메일형식@gmail.com",
                        hintStyle: TextStyle(fontSize: 13.0)),
                    onChanged: ((value) {
                      setState(() {
                        job = value;
                      });
                    }),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "직업을 입력해주세요.";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text('회원가입'),
                    ),
                  ),
                  onTap: () async {
                    if (id.isNotEmpty &&
                        pw.isNotEmpty &&
                        name.isNotEmpty &&
                        gender.isNotEmpty &&
                        born != 0 &&
                        intro.isNotEmpty &&
                        job.isNotEmpty) {
                      if (gender == _man) {
                        userGender = 1;
                        //1이면 남자
                      } else {
                        userGender = 0;
                        //0이면 여자
                      }

                      bool signupResult =
                          await Provider.of<UserModel>(context, listen: false)
                              .insertUser(id, pw, name, userGender, born, intro,
                                  address, job, userprofileurl);
                      if (signupResult) {
                        bool LoginResult =
                            await Provider.of<UserModel>(context, listen: false)
                                .getOneUserByLogin(id, pw);

                        if (LoginResult) {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('isLogin', true); //로그인
                          await prefs.setInt(
                              'loggedUserIdx',
                              await Provider.of<UserModel>(context,
                                      listen: false)
                                  .me
                                  .userIdx);
                          setState(() {
                            Loginmanwoman();
                          });

                          //id,pw확인후 남자페이지,여자페이지 구별
                          print('가입성공');
                        } else {
                          print('가입실패');
                        }
                      }
                    } else {
                      setState(() {
                        singup();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
