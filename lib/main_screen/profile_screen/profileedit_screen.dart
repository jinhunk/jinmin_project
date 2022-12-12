import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jinmin_project/model/user_model.dart';
import 'package:provider/provider.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  File? image1;
  bool image1Check = false;
  File? image2;
  File? image3;

  String image1Url = '';
  String image2Url = '';
  String image3Url = '';

  final _picker = ImagePicker();

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

  Future<String> _upLoadFireBase(var image) async {
    Reference storageReference =
        firebaseStorage.ref().child("user/-${DateTime.now()..microsecond}");
    UploadTask storageUploadTask = storageReference.putFile(image);
    await storageUploadTask.whenComplete(() => null);
    String downloadUrl = await storageReference.getDownloadURL();
    return downloadUrl;
  }

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 82, 79, 79),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          '프로필 수정',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(
              children: [
                GestureDetector(
                  child: const Text(
                    '저장',
                    style: TextStyle(color: Colors.pink, fontSize: 18.0),
                  ),
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
                            .userProfileImage(
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
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              image1 == null
                  ? Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: const EdgeInsets.only(left: 5.0, top: 20.0),
                      width: MediaQuery.of(context).size.width / 3.15,
                      height: MediaQuery.of(context).size.height / 6.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.pink)),
                      child: IconButton(
                        onPressed: () {
                          getImage(ImageSource.gallery, 1);
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 30.0,
                          color: Colors.pinkAccent,
                        ),
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
                    ),
              //이미지 1
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: const EdgeInsets.only(left: 5.0, top: 20.0),
                width: MediaQuery.of(context).size.width / 3.15,
                height: MediaQuery.of(context).size.height / 6.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.pink)),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    size: 30.0,
                    color: Colors.pinkAccent,
                  ),
                ),
              ),
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: const EdgeInsets.only(left: 5.0, top: 20.0),
                width: MediaQuery.of(context).size.width / 3.15,
                height: MediaQuery.of(context).size.height / 6.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.pink)),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    size: 30.0,
                    color: Colors.pinkAccent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
