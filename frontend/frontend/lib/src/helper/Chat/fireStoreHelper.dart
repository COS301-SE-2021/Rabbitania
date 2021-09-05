import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/Chat/ChatFirestoreUserModel.dart';
import 'package:frontend/src/models/Chat/ChatMessageModel.dart';
import 'package:frontend/src/models/Chat/GroupChatMessageModel.dart';
import 'package:rxdart/streams.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FireStoreHelper {
  getUsersCollectionFromFireStore() {
    CollectionReference users = firestore.collection('users');

    print(users.doc().get());
  }

  createNewUsersDocsWithUid(uid, displayName, email, avatar) async {
    var refCollection = firestore.collection('users');
    var refChatsCollection = firestore.collection('chats').doc('$uid').set({});
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

  getChat(int idUser, int myId) {
    //get chats of user i want to talk to
    //filter those messages by searching for messages he sent to me
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

  Future sendMessage(int idUser, int myId, String message) async {
    //navigate to my messages
    final refMessagesMe = firestore.collection('chats/$myId/messages');
    final refMessagesThem = firestore.collection('chats/$idUser/messages');
    //create new message and show that you sent it
    final newMessage = ChatMessageModel(
      uid: myId,
      toUid: idUser,
      message: message,
      dateCreated: DateTime.now(),
    );

    //add new message to recipeint collection
    await refMessagesMe.add(
      newMessage.toJson(),
    );
    await refMessagesThem.add(
      newMessage.toJson(),
    );
    //update messaged user that he/she has a new message
    //final refUsers = firestore.collection('users/$idUser').doc().update({});
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
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserById(idUser) {
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
}
