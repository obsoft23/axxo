// models/chat_message.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String id;
  final String senderId;
  final String content;
  final String type; // text, image, or emoji
  final DateTime timestamp;
  final bool isSeen;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.content,
    required this.type,
    required this.timestamp,
    required this.isSeen,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> data, String id) {
    return ChatMessage(
      id: id,
      senderId: data['senderId'],
      content: data['content'],
      type: data['type'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      isSeen: data['isSeen'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'content': content,
      'type': type,
      'timestamp': timestamp,
      'isSeen': isSeen,
    };
  }
}
