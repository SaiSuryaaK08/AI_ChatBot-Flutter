import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
// import 'package:morse_code_translator/morse_code_translator.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_ai/api_services.dart';
import 'package:voice_ai/chat_model.dart';
import 'package:voice_ai/tts.dart';

import 'Chat_Bubble.dart';

class Speech_Screen extends StatefulWidget {
  const Speech_Screen({Key? key}) : super(key: key);

  @override
  State<Speech_Screen> createState() => _Speech_ScreenState();
}

class _Speech_ScreenState extends State<Speech_Screen> {
  SpeechToText speechToText = SpeechToText();
  var text = "Hold the button to speak";
  var apikey = "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";
  // var de ="Morse Code";
  // MorseCode  meroMorseCode = MorseCode();
  var is_Listening = false;

  final List<ChatMessage> messages = [];

  var scrollController = ScrollController();
  scrollMethod() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75.0,
        animate: is_Listening,
        duration: const Duration(milliseconds: 2000),
        glowColor: Colors.teal,
        repeat: true,
        repeatPauseDuration: const Duration(milliseconds: 1000),
        showTwoGlows: true,
        child: GestureDetector(
          onTapDown: (details) async {
            if (!is_Listening) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  is_Listening = true;
                  speechToText.listen(onResult: (result) {
                    setState(() {
                      text = result.recognizedWords;
                      // de = meroMorseCode.enCode(text);
                    });
                  });
                });
              }
            }
            setState(() {
              is_Listening = true;
            });
          },
          onTapUp: (details) async {
            setState(() {
              is_Listening = false;
            });
            await speechToText.stop();

            if (text.isNotEmpty && text != "Hold the button to speak") {
              messages.add(
                ChatMessage(text: text, type: ChatMessageType.user),
              );
              var msg = await ApiServices.sendMessage(text);
              msg=msg.trim();
              setState(() {
                messages.add(
                  ChatMessage(text: msg, type: ChatMessageType.bot),
                );
              });
              Future.delayed(Duration(milliseconds: 500),(){
                TextToSpeech.speak(msg);
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Failed to process try again :("),
                ),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: CircleAvatar(
              backgroundColor: Colors.cyan,
              radius: 35,
              child: Icon(
                is_Listening ? Icons.mic : Icons.mic_none,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: const Icon(
          Icons.sort_rounded,
          color: Colors.white,
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.teal,
        title: const Text(
          "Voice Assistant",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        child: //turn to column to add another text widget for en
            Column(
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: is_Listening ? Colors.black87 : Colors.black54),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 5),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  controller: scrollController,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    var chat = messages[index];
                    return chatBubble(chatText: chat.text, type: chat.type);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "Developed by Zai",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: is_Listening ? Colors.black87 : Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
