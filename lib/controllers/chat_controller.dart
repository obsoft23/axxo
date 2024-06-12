// controllers/chat_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vixo/models/chat_model.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ChatController extends GetxController {
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final TextEditingController messageController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  final CollectionReference messagesCollection =
      FirebaseFirestore.instance.collection('messages');

  @override
  void onInit() {
    super.onInit();
    messages.bindStream(getMessagesStream());
  }

  Stream<List<ChatMessage>> getMessagesStream() {
    return messagesCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              ChatMessage.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  Future<void> sendMessage(String content, String type) async {
    final newMessage = ChatMessage(
      id: '',
      senderId: 'user1', // Replace with the actual sender ID
      content: content,
      type: type,
      timestamp: DateTime.now(),
      isSeen: false,
    );

    await messagesCollection.add(newMessage.toMap());
  }

  Future<void> sendImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference storageReference =
          FirebaseStorage.instance.ref().child('chat_images/$fileName');
      final UploadTask uploadTask = storageReference.putFile(imageFile);
      final TaskSnapshot downloadUrl = await uploadTask;
      final String url = await downloadUrl.ref.getDownloadURL();

      await sendMessage(url, 'image');
    }
  }
}
