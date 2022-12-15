import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart';

class Animal extends StatefulWidget {
  const Animal({Key? key}) : super(key: key);

  @override
  _AnimalState createState() => _AnimalState();
}

class _AnimalState extends State<Animal> {
  File? image1;
  File? image2;
  File? image3;

  String image1Url = '';
  String image2Url = '';
  String image3Url = '';

  final _picker = ImagePicker();

  bool image1Check = false;

//파이어베이스에 사진저장
  Future<String> _upLoadFireBase(var image) async {
    Reference storageReference = firebaseStorage
        .ref()
        .child("useranimai/-${DateTime.now()..microsecond}");
    UploadTask storageUploadTask = storageReference.putFile(image);
    await storageUploadTask.whenComplete(() => null);
    String downloadUrl = await storageReference.getDownloadURL();
    return downloadUrl;
  }

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

// 사진 업로드
  void getImage(ImageSource imageSource, int check) async {
    bool permitted = true;

    if (permitted) {
      final pickedFile = await _picker.pickImage(source: imageSource);
      if (check == 1) {
        if (pickedFile != null) {
          setState(() {
            image1 = File(pickedFile.path);
            image1Check = true;
          });
        }
      } else if (check == 2) {
        setState(() {
          image2 = File(pickedFile!.path);
        });
      } else {
        setState(() {
          image3 = File(pickedFile!.path);
        });
      }
    }
  }

  Widget _bodyheader() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: const [
              Text(
                '반려동물 사진을 등록해서\n  친구들에게 자랑하세요!',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '내 프로필 상세에 반영되며 ',
                style: TextStyle(fontSize: 17.0),
              ),
              Text(
                '더 많은 친구들에게 호감을 받을 수 있습니다.',
                style: TextStyle(fontSize: 17.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bodyimage() {
    return image1 == null
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
            width: MediaQuery.of(context).size.width / 3.5,
            height: MediaQuery.of(context).size.height / 7.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: const Color.fromARGB(255, 247, 215, 226),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.pink,
              size: 40.0,
            ),
          )
        : Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: const EdgeInsets.only(left: 5.0, top: 20.0),
            width: MediaQuery.of(context).size.width / 3.15,
            height: MediaQuery.of(context).size.height / 6.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.pink)),
            child: InkWell(
              onTap: () {
                getImage(ImageSource.gallery, 1);
              },
              child: Image.file(
                image1!,
                fit: BoxFit.cover,
              ),
            ),
          );
  }

  Widget bodybottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Row(
              children: const [
                Text(
                  '반려동물이랑 같이 찍은 사진',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  width: 2.0,
                ),
                Icon(
                  Icons.check_circle,
                  color: Colors.amber,
                  size: 17.0,
                ),
              ],
            ),
            Row(
              children: const [
                Text(
                  '반려동물만 같이 멋진 사진',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  width: 2.0,
                ),
                Icon(
                  Icons.check_circle,
                  color: Colors.amber,
                  size: 17.0,
                ),
              ],
            ),
            const Text(
              '반려동물과 관련 없는 사진일 경우 거절될 수 있습니다.',
              style: TextStyle(color: Colors.black),
            ),
          ],
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
        iconTheme: const IconThemeData(),
        title: const Text(
          '반려동물 등록',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 13.0, right: 20.0),
            child: GestureDetector(
              onTap: () async {
                if (image1Check) {
                  //true
                  image1Url = await _upLoadFireBase(image1);
                } else {
                  //false
                  image1Url = 'noImage';
                }

                bool userResult =
                    await Provider.of<UserModel>(context, listen: false)
                        .userProfileAnimalImage(
                  Provider.of<UserModel>(context, listen: false).me.userIdx,
                  image1Url,
                );
                if (userResult) {
                  //이미지 가져오기 성공하면
                  await Provider.of<UserModel>(context, listen: false)
                      .getOneUserByUserIdx(
                          Provider.of<UserModel>(context, listen: false)
                              .me
                              .userIdx);
                  Navigator.pop(context);
                }
              },
              child: const Text(
                '저장',
                style: TextStyle(color: Colors.pink, fontSize: 17.0),
              ),
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
        children: [
          _bodyheader(),
          const SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  getImage(ImageSource.gallery, 1);
                },
                child: _bodyimage(),
              ),
              _bodyimage(),
              _bodyimage()
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_bodyimage(), _bodyimage(), _bodyimage()],
          ),
          const SizedBox(
            height: 70.0,
          ),
          bodybottom()
        ],
      ),
    );
  }
}
