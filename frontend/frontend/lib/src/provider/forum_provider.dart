import 'dart:convert';
import 'dart:io';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:http/http.dart' as http;

////////////////////////////////////////////////////////////////
/// Forum Requests
///////////////////////////////////////////////////////////////

Future<List<ForumObj>> fetchForum() async {
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  String url = 'http://10.0.2.2:5000/api/Forum/RetrieveForums';

  HttpClientRequest request = await client.getUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');

  HttpClientResponse response1 = await request.close();
  String reply = await response1.transform(utf8.decoder).join();

  List<dynamic> tList = ForumObjs.fromJson(jsonDecode(reply)).forumThreadList;

  List<ForumObj> threadObj = [];

  for (var t in tList) {
    threadObj.add(ForumObj.fromJson(t));
  }

  client.close();
  return threadObj;
}

Future<bool> deleteForum(int currentForumID) async {
  try {
    if (currentForumID < 0) {
      throw ("Error Forum ID is Incorrect");
    }
    final response = await http.delete(
      Uri.parse('https://10.0.2.2:5001/api/Forum/DeleteForum'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'forumId': currentForumID,
      }),
    );
    //print("CODE ============" + response.statusCode.toString());
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      throw ("Failed to delete, error code" + response.statusCode.toString());
    }
  } catch (Exception) {
    return false;
  }
}

////////////////////////////////////////////////////////////////
/// Forum Threads
///////////////////////////////////////////////////////////////

Future<List<ForumThread>> fetchForumThreads(int forumIdentifier) async {
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  String url = 'http://10.0.2.2:5000/api/Forum/RetrieveForumThreads?ForumID=' +
      forumIdentifier.toString();

  HttpClientRequest request = await client.getUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');

  HttpClientResponse response1 = await request.close();
  String reply = await response1.transform(utf8.decoder).join();
  //print(jsonDecode(reply));

  List? tList = ForumThreads.fromJson(jsonDecode(reply)).forumThreadList;

  List<ForumThread> threadObj = [];

  if (tList != null) {
    for (var t in tList) {
      threadObj.add(ForumThread.fromJson(t));
    }

    client.close();
    return threadObj;
  } else {
    return threadObj;
  }
}

Future<bool> deleteForumThread(int currentThreadID) async {
  try {
    if (currentThreadID < 0) {
      throw ("Error: Forum Thread ID is Incorrect");
    }
    final response = await http.delete(
      Uri.parse('https://10.0.2.2:5001/api/Forum/DeleteForumThread'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'forumThreadId': currentThreadID,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      throw ("Falied to delete, error code" + response.statusCode.toString());
    }
  } catch (Exception) {
    return false;
  }
}

///////////////////////////////////////////////////////////////////
/// ForumThreadComments
///////////////////////////////////////////////////////////////
///
///
Future<List<ThreadComments>> fetchThreadComments(int ThreadIdentifier) async {
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  String url =
      'http://10.0.2.2:5000/api/Forum/RetrieveThreadComments?ForumThreadID=' +
          ThreadIdentifier.toString();

  HttpClientRequest request = await client.getUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');

  HttpClientResponse response1 = await request.close();
  String reply = await response1.transform(utf8.decoder).join();
  print(jsonDecode(reply));

  List? cList =
      ForumThreadComments.fromJson(jsonDecode(reply)).forumCommentsList;

  List<ThreadComments> CommentObj = [];

  if (cList != null) {
    for (var t in cList) {
      CommentObj.add(ThreadComments.fromJson(t));
    }

    client.close();
    return CommentObj;
  } else {
    return CommentObj;
  }
}

Future<bool> deleteComment(int currentCommentId) async {
  try {
    print(currentCommentId);
    if (currentCommentId < 0) {
      throw ("Error: Comment Id is invalid");
    }
    final response = await http.delete(
      Uri.parse('https://10.0.2.2:5001/api/Forum/DeleteThreadComment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'threadCommentId': currentCommentId,
        },
      ),
    );
    //print("CODE ============" + response.statusCode.toString());
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      throw ("Failed to delete, error code" + response.statusCode.toString());
    }
  } catch (Exception) {
    return false;
  }
}
