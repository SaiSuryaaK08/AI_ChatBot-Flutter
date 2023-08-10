import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voice_ai/speech_screen.dart';
import 'package:voice_ai/text_to_speech_screen.dart';
import 'package:voice_ai/tts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  TextToSpeech.initTTS();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Text to speech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Speech_Screen(),
    );
  }
}
