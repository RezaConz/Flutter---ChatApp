import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((e) {
        final user = e.data();

        return user;
      }).toList();
    });
  }

  //send msg
  Future<void> sendMessage(String receivedID, message) async {
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        currentUserID, currentUserEmail, receivedID, message, timestamp);

    List<String> id = [currentUserID, receivedID];
    id.sort();
    String chatRoomId = id.join("_");

    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //received msg

  Stream<QuerySnapshot> getMessage(String userID, otherUserID) {
    List<String> id = [userID, otherUserID];
    id.sort();
    String chatRoomId = id.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
