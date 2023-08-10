import 'package:flutter/material.dart';

import 'chat_model.dart';
Widget chatBubble({required chatText, required ChatMessageType? type}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(
        backgroundColor: Colors.teal[700],
        child: type == ChatMessageType.bot?Icon(Icons.computer): Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(bottom: 8),
          decoration:  BoxDecoration(
            color: type == ChatMessageType.bot? Colors.teal :Colors.white,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: Text(
            "${chatText}",
            style: TextStyle(
                color: type == ChatMessageType.bot? Colors.white :Colors.teal,
                fontWeight: type ==ChatMessageType.bot?FontWeight.w600:FontWeight.w400,
                fontSize: 12),
          ),
        ),
      ),
    ],
  );
}