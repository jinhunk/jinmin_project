import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jinmin_project/model/meetingfeed.dart';
import 'package:jinmin_project/model/user_model.dart';

import 'package:provider/provider.dart';

class WriteFeedScreen extends StatefulWidget {
  const WriteFeedScreen({Key? key}) : super(key: key);

  @override
  _WriteFeedScreenState createState() => _WriteFeedScreenState();
}

class _WriteFeedScreenState extends State<WriteFeedScreen> {
  // late String title;
  late String content;
  late String city;

  File? image1;
  bool image1Check = false;
  File? image2;
  File? image3;

  String image1Url = '';
  String image2Url = '';
  String image3Url = '';

  // File? singleImage;

  // File? croppedFile;

  final _picker = ImagePicker();

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

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
        firebaseStorage.ref().child("feed/-${DateTime.now()..microsecond}");
    UploadTask storageUploadTask = storageReference.putFile(image);
    await storageUploadTask.whenComplete(() => null);
    String downloadUrl = await storageReference.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomSheet: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: const Color.fromARGB(255, 250, 249, 249),
                    elevation: 0.0),
                onPressed: () {
                  // _pickimage();
                  getImage(ImageSource.gallery, 1);
                },
                label: const Text(
                  '사진추가',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 17.0),
                ),
                icon: const Icon(
                  Icons.filter,
                  color: Colors.pink,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(),
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const Text(
            '스토리 작성',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 15.0),
              child: GestureDetector(
                onTap: () async {
                  if (image1Check) {
                    //true
                    image1Url = await _upLoadFireBase(image1);
                  } else {
                    //false
                    image1Url = 'noImage';
                  }

                  // if(image2Check){
                  //   image2Url = await _upLoadFireBase(image2);
                  // }else{
                  //   image2Url = 'noImage';
                  // }

                  // if(image3Check){
                  //   image3Url = await _upLoadFireBase(image3);
                  // }else{
                  //   image3Url = 'noImage';
                  // }
                  if (content.isNotEmpty && city.isNotEmpty) {
                    bool feedResult = await Provider.of<MeetingFeedModel>(
                            context,
                            listen: false)
                        .insertMeetingFeed(
                            Provider.of<UserModel>(context, listen: false)
                                .me
                                .userIdx,
                            city,
                            '',
                            content,
                            123.0000,
                            123.0000,
                            image1Url,
                            '',
                            '');
                    if (feedResult) {
                      Provider.of<MeetingFeedModel>(context, listen: false)
                          .getAllFeedByCity(
                              Provider.of<UserModel>(context, listen: false)
                                  .me
                                  .userAddress);
                      Navigator.pop(context);
                    } else {
                      print('네트워크 오류');
                    }
                  } else {
                    print('전체를 입력해주세여');
                  }
                },
                child: const Text(
                  '등록',
                  style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // TextField(
              //   decoration: const InputDecoration(
              //     hintText: '제목',
              //     hintStyle: TextStyle(fontSize: 13.0),
              //   ),
              //   onChanged: (value) {
              //     title = value;
              //   },
              // ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  maxLines: 7,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        '당신에 대해 이야기해주세요.\n매력적인 스토리는 친구들에게 공감을\n많이 받을 수 있습니다.\n\n카카오톡 아이디 또는 메신저 등 개인 연락처를\n노출할 경우에는 스토리가 비노출 됩니다.',
                    hintStyle: TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                  onChanged: (value) {
                    content = value;
                  },
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: '  만남을 원하는 지역',
                    hintStyle: TextStyle(fontSize: 17.0),
                  ),
                  onChanged: (value) {
                    city = value;
                  },
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              image1 == null
                  ? Container()
                  : Stack(
                      children: [
                        Image.file(
                          image1!,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          left: 355.0,
                          child: GestureDetector(
                            child: const Icon(
                              Icons.cancel_rounded,
                              size: 35.0,
                              color: Colors.white,
                            ),
                            onTap: () {
                              setState(() {
                                image1 = null;
                              }); // 사진 지우기
                            },
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _pickimage() async {
  //   final pickedImage = await singlePicker.pickImage(
  //     source: (ImageSource.gallery),
  //   );
  //   if (pickedImage != null) {
  //     singleImage = File(pickedImage.path);
  //   }
  // File? croppedFile = await ImageCropper().cropImage(
  //     sourcePath: singleImage!.path,
  //     aspectRatioPresets: [
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.ratio3x2,
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.ratio16x9
  //     ],
  //     androidUiSettings: AndroidUiSettings(
  //         toolbarTitle: '사진 편집',
  //         toolbarColor: Colors.deepOrange,
  //         toolbarWidgetColor: Colors.white,
  //         initAspectRatio: CropAspectRatioPreset.original,
  //         lockAspectRatio: false),
  //     iosUiSettings: IOSUiSettings(
  //       title: '사진 편집',
  //       doneButtonTitle: '완료',
  //       cancelButtonTitle: '나가기',
  //       minimumAspectRatio: 1.0,
  //     ));
  // if (croppedFile != null) {
  //   setState(() {
  //     singleImage = croppedFile;
  //   });
  // }
  // }
}
