import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech{
  static FlutterTts tts= FlutterTts();

  static initTTS()async{
    print(await tts.getLanguages);
    tts.setLanguage("ja-JP");
    tts.setPitch(1.0);
    tts.setSpeechRate(0.6);
  }

  static speak(String text)async{
    tts.setStartHandler(() {
      print('hello');
    });
    tts.setErrorHandler((message) { 
      print(message);
    });
    await tts.awaitSpeakCompletion(true);
    tts.speak(text);
  }
}