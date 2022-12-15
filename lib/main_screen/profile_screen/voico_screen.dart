// import 'package:flutter/material.dart';

// class Voice extends StatelessWidget {
//   const Voice({Key? key}) : super(key: key);

//   Widget _bodytop() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 120),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Column(
//             children: const [
//               Text(
//                 '목소리로 당신의 매력을 어필하세요.',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20.0),
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               Text(
//                 '목소리는 프로필 신뢰도를 높이고',
//                 style: TextStyle(fontSize: 17.0),
//               ),
//               Text(
//                 '친구들에게 더 많은 호감을 얻을 수 있습니다.',
//                 style: TextStyle(fontSize: 17.0),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _bodymicbutton(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width / 1.6,
//       height: MediaQuery.of(context).size.height / 3.5,
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 250, 237, 241),
//         borderRadius: BorderRadius.circular(120),
//       ),
//       child: const Icon(
//         Icons.mic,
//         size: 120.0,
//         color: Colors.pink,
//       ),
//     );
//   }

//   Widget _bodybottombutton(BuildContext context, String title) {
//     return Container(
//         padding: const EdgeInsets.symmetric(vertical: 13.0),
//         width: MediaQuery.of(context).size.width / 1.1,
//         height: MediaQuery.of(context).size.height / 16.0,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20), color: Colors.pink),
//         child: Text(
//           title,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             fontSize: 20.0,
//             color: Colors.white,
//           ),
//         ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         iconTheme: const IconThemeData(color: Colors.black54),
//         title: const Text(
//           '목소리 등록',
//           style: TextStyle(color: Colors.black),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(0.0),
//           child: Container(
//             margin: const EdgeInsets.only(bottom: 6.0),
//             width: MediaQuery.of(context).size.width / 1.0,
//             height: MediaQuery.of(context).size.height / 500.0,
//             color: const Color.fromARGB(255, 248, 245, 245),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           _bodytop(),
//           const SizedBox(
//             height: 40.0,
//           ),
//           _bodymicbutton(context),
//           const SizedBox(
//             height: 100.0,
//           ),
//           _bodybottombutton(context, '목소리 중단하기'),
//           const SizedBox(
//             height: 20.0,
//           ),
//           // _bodybottombutton(context, '목소리 녹음하기')
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart' show DateFormat;

class Voice extends StatefulWidget {
  const Voice({super.key});

  @override
  State<Voice> createState() => _VoiceState();
}

class _VoiceState extends State<Voice> {
  late FlutterSoundRecorder _recordingSession;
  final recordingPlayer = AssetsAudioPlayer();

  bool _playAudio = false;

  late String pathToAudio; //녹음된 오디오를 저장하는 전화기의 위치

  String _timerText = '00:00:00';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializer();
  }

  void initializer() async {
    pathToAudio = '/sdcard/Download/temp.wav';
    _recordingSession = FlutterSoundRecorder();
    await _recordingSession.openAudioSession(
        focus: AudioFocus.requestFocusAndStopOthers,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);
    await _recordingSession
        .setSubscriptionDuration(const Duration(milliseconds: 10));
    // await initializeDateFormatting();
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  } // 로드시 앱 초기화

  Future<void> startRecording() async {
    Directory directory = Directory(path.dirname(pathToAudio));
    if (!directory.existsSync()) {
      directory.createSync();
    }
    _recordingSession.openAudioSession();
    await _recordingSession.startRecorder(
      toFile: pathToAudio,
      codec: Codec.pcm16WAV,
    );
    StreamSubscription _recorderSubscription =
        _recordingSession.onProgress!.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
          isUtc: true);
      var timeText = DateFormat('mm:ss:SS', 'en_GB').format(date);
      setState(() {
        _timerText = timeText.substring(0, 8);
      });
    });
    _recorderSubscription.cancel();
  } //스타트(마이크아이콘)

  Future<String?> stopRecording() async {
    _recordingSession.closeAudioSession();
    return await _recordingSession.stopRecorder();
  } //스탑아이콘

  Future<void> playFunc() async {
    recordingPlayer.open(
      Audio.file(pathToAudio),
      autoStart: true,
      showNotification: true,
    );
  } //플레이

  Future<void> stopPlayFunc() async {
    recordingPlayer.stop();
  } //스탑플레이

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text('Audio Recording and Playing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Center(
                child: Text(
                  _timerText,
                  style: const TextStyle(fontSize: 70, color: Colors.red),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                createElevatedButton(
                  icon: Icons.mic,
                  iconColor: Colors.red,
                  onPressFunc: startRecording,
                ),
                const SizedBox(
                  width: 30,
                ),
                createElevatedButton(
                  icon: Icons.stop,
                  iconColor: Colors.red,
                  onPressFunc: stopRecording,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  elevation: 9.0, backgroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  _playAudio = !_playAudio;
                });
                if (_playAudio) playFunc();
                if (!_playAudio) stopPlayFunc();
              },
              icon: _playAudio
                  ? const Icon(
                      Icons.stop,
                    )
                  : const Icon(Icons.play_arrow),
              label: _playAudio
                  ? const Text(
                      "Stop",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    )
                  : const Text(
                      "Play",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

//버튼 아이콘 ,아이콘컬러, onpressd
ElevatedButton createElevatedButton(
    {required IconData icon,
    required Color iconColor,
    required Function onPressFunc}) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(6.0),
      side: const BorderSide(
        color: Colors.red,
        width: 4.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      elevation: 9.0,
    ),
    onPressed: () {},
    icon: Icon(
      icon,
      color: iconColor,
      size: 38.0,
    ),
    label: const Text(''),
  );
}
