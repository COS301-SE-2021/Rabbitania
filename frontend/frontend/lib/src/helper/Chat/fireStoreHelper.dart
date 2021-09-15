import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/Chat/chatFirestoreUserModel.dart';
import 'package:frontend/src/models/Chat/chatMessageModel.dart';
import 'package:frontend/src/models/Chat/groupChatMessageModel.dart';
import 'package:rxdart/streams.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FireStoreHelper {
  createNewUsersDocsWithUid(uid, displayName, email, avatar) async {
    var refCollection = firestore.collection('users');
    ChatFirestoreUserModel newUser = ChatFirestoreUserModel(
      uid: uid,
      displayName: displayName,
      email: email,
      avatar: avatar,
    );
    refCollection.add(newUser.toJson());
  }

  //function adds user from inHouse api information to firestore users collection
  getUsersDocumentsFromFireStoreAsStream() {
    CollectionReference users = firestore.collection('users');
    return users.snapshots();
  }

  //function to get direct messages chats from firestore
  getChat(int idUser, int myId) {
    return firestore
        .collection('chats/$myId/messages')
        .orderBy('dateCreated', descending: true)
        .snapshots();
  }

  //get all group chats applicable to the current logged in user
  getGroupChats(int myId) {
    return firestore
        .collection('groupChat')
        .where('participants', arrayContains: myId)
        .snapshots();
  }

  //send direct message chat to participant
  Future sendMessage(int idUser, int myId, String message) async {
    final refMessagesMe = firestore.collection('chats/$myId/messages');
    final refMessagesThem = firestore.collection('chats/$idUser/messages');
    final newMessage = ChatMessageModel(
      uid: myId,
      toUid: idUser,
      message: message,
      dateCreated: DateTime.now(),
    );
    await refMessagesMe.add(
      newMessage.toJson(),
    );
    await refMessagesThem.add(
      newMessage.toJson(),
    );
  }

  //used to create new message in desired groupChat room
  Future sendGroupChatMessage(String roomName, int myId, String message) async {
    final refGroupMessages =
        firestore.collection('groupChat/$roomName/messages');
    final newGroupChatMessage = GroupChatMessageModel(
      uid: myId,
      message: message,
      dateCreated: DateTime.now(),
    );
    await refGroupMessages.add(
      newGroupChatMessage.toJson(),
    );
  }

  //function to get user object using user idUser
  getUserById(idUser) {
    return firestore
        .collection('users')
        .where('uid', isEqualTo: idUser)
        .snapshots();
  }

  //function for getting all chats based off room name
  getGroupChatByRoomName(roomName) {
    return firestore
        .collection('groupChat/$roomName/messages')
        .orderBy('dateCreated', descending: true)
        .snapshots();
  }

  getGroupRoomByRoomName(roomName) {
    return firestore
        .collection('groupChat')
        .where('roomName', isEqualTo: roomName)
        .snapshots();
  }

  //function for creating new groupchat room
  createGroupChatRoom(String roomName, users, imageBae64) {
    final refGroupRooms = firestore
        .collection('groupChat')
        .doc('$roomName')
        .set({
      'participants': users,
      'roomName': roomName,
      'avatar': imageBae64
    });
  }

  //function to delete group chat room in firebase
  deleteGroupChatByRoomName(String roomName) async {
    firestore.collection('groupChat').doc('$roomName').delete();
  }

  //function to unsubscribe user from a group chat
  removeUserFromGroup(roomName, uid) {
    firestore.collection('groupChat').doc('$roomName').update({
      'participants': FieldValue.arrayRemove([uid])
    });
  }

  //function to add a user to an existing group chat
  addUserToGroup(roomName, uid) {
    firestore.collection('groupChat').doc('$roomName').update({
      'participants': FieldValue.arrayUnion([uid])
    });
  }
}
