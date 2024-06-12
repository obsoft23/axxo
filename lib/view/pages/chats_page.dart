// views/chat_page.dart
// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:vixo/models/chat_model.dart';
import 'package:vixo/theme/constants.dart';
import 'package:intl/intl.dart' as intl;

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                reverse: true,
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatController.messages[index];
                  return ChatBubble(message: message);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MessageInputField(),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    bool isMe = message.senderId == 'user1'; // Replace with the actual user ID

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (message.type == 'text')
              Text(
                message.content,
                style: TextStyle(color: isMe ? Colors.white : Colors.black),
              )
            else if (message.type == 'image')
              Image.network(message.content)
            else if (message.type == 'emoji')
              Text(
                message.content,
                style: TextStyle(fontSize: 32.0),
              ),
            SizedBox(height: 4.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  intl.DateFormat('hh:mm a').format(message.timestamp),
                  style: TextStyle(
                      color: isMe ? Colors.white70 : Colors.black54,
                      fontSize: 12.0),
                ),
                SizedBox(width: 8.0),
                if (isMe)
                  Icon(
                    message.isSeen ? Icons.done_all : Icons.done,
                    color: message.isSeen ? Colors.white : Colors.white54,
                    size: 16.0,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MessageInputField extends StatefulWidget {
  const MessageInputField({super.key});

  @override
  _MessageInputFieldState createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  bool _isEmojiPickerVisible = false;

  void _onEmojiSelected(Emoji emoji) {
    chatController.messageController.text += emoji.emoji;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isEmojiPickerVisible)
          EmojiPicker(
            onEmojiSelected: (category, emoji) {
              _onEmojiSelected(emoji);
            },
          ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.emoji_emotions),
              onPressed: () {
                setState(() {
                  _isEmojiPickerVisible = !_isEmojiPickerVisible;
                });
              },
            ),
            Expanded(
              child: TextField(
                controller: chatController.messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.image),
              onPressed: chatController.sendImage,
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                if (chatController.messageController.text.isNotEmpty) {
                  chatController.sendMessage(
                      chatController.messageController.text, 'text');
                  chatController.messageController.clear();
                  setState(() {
                    _isEmojiPickerVisible = false;
                  });
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
