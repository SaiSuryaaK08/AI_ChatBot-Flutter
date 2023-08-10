import 'package:flutter/material.dart';
import 'package:voice_ai/tts.dart';

class TTSScreen extends StatelessWidget {
  const TTSScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Text To Speech"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: textController,

          ),
          ElevatedButton(
            onPressed: () {
              TextToSpeech.speak(textController.text);
            },
            child: Text("Speak"),
          ),
        ],
      ),
    );
  }
}
