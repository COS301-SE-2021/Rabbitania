import 'dart:convert';
import 'dart:io';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/widgets/Forum/forumCreateThreadCard.dart';
import 'package:frontend/src/widgets/Forum/forumEditForumThreadCard.dart';
import 'package:http/http.dart' as http;

////////////////////////////////////////////////////////////////
/// Forum Requests
///////////////////////////////////////////////////////////////

Future<List<ForumObj>> fetchForum() async {
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  String url = 'http://10.0.2.2:5000/api/Forum/RetrieveForums';
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUnVudGltZVRlcnJvcnMiLCJleHAiOjE2Mjg5NjkyNDcsImlzcyI6InJ1bnRpbWUudGVycm9ycyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDE7aHR0cDovL2xvY2FsaG9zdDo1MDAwIn0.MBTk3DXysmd7UxtLRuDEzLMXfUH0yeaoU8BluEnW3b0";
  HttpClientRequest request = await client.getUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.headers.set('Authorization', 'Bearer $token');

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
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUnVudGltZVRlcnJvcnMiLCJleHAiOjE2Mjg5NjkyNDcsImlzcyI6InJ1bnRpbWUudGVycm9ycyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDE7aHR0cDovL2xvY2FsaG9zdDo1MDAwIn0.MBTk3DXysmd7UxtLRuDEzLMXfUH0yeaoU8BluEnW3b0";
    final response = await http.delete(
      Uri.parse('https://10.0.2.2:5001/api/Forum/DeleteForum'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
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
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUnVudGltZVRlcnJvcnMiLCJleHAiOjE2Mjg5NjkyNDcsImlzcyI6InJ1bnRpbWUudGVycm9ycyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDE7aHR0cDovL2xvY2FsaG9zdDo1MDAwIn0.MBTk3DXysmd7UxtLRuDEzLMXfUH0yeaoU8BluEnW3b0";
  HttpClientRequest request = await client.getUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.headers.set('Authorization', 'Bearer $token');

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
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUnVudGltZVRlcnJvcnMiLCJleHAiOjE2Mjg5NjkyNDcsImlzcyI6InJ1bnRpbWUudGVycm9ycyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDE7aHR0cDovL2xvY2FsaG9zdDo1MDAwIn0.MBTk3DXysmd7UxtLRuDEzLMXfUH0yeaoU8BluEnW3b0";
    final response = await http.delete(
      Uri.parse('https://10.0.2.2:5001/api/Forum/DeleteForumThread'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
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

Future<String> addNewForum(String title, int userID) async {
  try {
    if (title == "") {
      throw ("Cannot Submit Empty Fields");
    }
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUnVudGltZVRlcnJvcnMiLCJleHAiOjE2Mjg5NjkyNDcsImlzcyI6InJ1bnRpbWUudGVycm9ycyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDE7aHR0cDovL2xvY2FsaG9zdDo1MDAwIn0.MBTk3DXysmd7UxtLRuDEzLMXfUH0yeaoU8BluEnW3b0";
    final response = await http.post(
      Uri.parse('https://10.0.2.2:5001/api/Forum/CreateForum'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        "forumId": 0,
        "forumTitle": title,
        "createdDate": "2021-08-04T11:50:49.398Z",
        "userId": userID
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return ("Successfully uploaded new Form");
    } else {
      throw ("Failed to create new thread error" +
          response.statusCode.toString());
    }
  } catch (Exception) {
    return ("Error: " + Exception.toString());
  }
}

Future<String> addNewForumThread(
    int currentId, String title, String body, int userId) async {
  try {
    if (title == "") {
      throw ("Cannot Submit Empty Title");
    }

    if (ForumCreateImg64 != "") {
      ForumCreateInputImage = ForumCreateImg64;
    }
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUnVudGltZVRlcnJvcnMiLCJleHAiOjE2Mjg5NjkyNDcsImlzcyI6InJ1bnRpbWUudGVycm9ycyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDE7aHR0cDovL2xvY2FsaG9zdDo1MDAwIn0.MBTk3DXysmd7UxtLRuDEzLMXfUH0yeaoU8BluEnW3b0";
    final response = await http.post(
      Uri.parse('https://10.0.2.2:5001/api/Forum/CreateForumThread'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        "forumThreadId": 0,
        "forumThreadTitle": title,
        "forumThreadBody": body,
        "createdDate": "2021-08-04T13:45:13.091Z",
        "imageUrl": ForumCreateInputImage,
        "userId": userId,
        "forumId": currentForumID
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      ForumCreateImageFile = null;
      return ("Successfully uploaded new Forum Thread");
    } else {
      ForumCreateImageFile = null;
      throw ("Failed to create new thread error" +
          response.statusCode.toString());
    }
  } catch (Exception) {
    ForumCreateImageFile = null;
    return ("Error: " + Exception.toString());
  }
}

Future<String> editNewForum(String title) async {
  print(title);
  try {
    if (title == "") {
      throw ("Cannot Submit Empty Fields");
    }
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUnVudGltZVRlcnJvcnMiLCJleHAiOjE2Mjg5NjkyNDcsImlzcyI6InJ1bnRpbWUudGVycm9ycyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDE7aHR0cDovL2xvY2FsaG9zdDo1MDAwIn0.MBTk3DXysmd7UxtLRuDEzLMXfUH0yeaoU8BluEnW3b0";
    final response = await http.put(
      Uri.parse('https://10.0.2.2:5001/api/Forum/EditForum'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
          <String, dynamic>{"forumId": currentForumID, "forumTitle": title}),
    );
    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 100) {
      return ("Successfully uploaded new notice");
    } else {
      throw ("Failed to create new thread error" +
          response.statusCode.toString());
    }
  } catch (Exception) {
    return Exception.toString();
  }
}

///////////////////////////////////////////////////////////////////
/// ForumThreadComments
///////////////////////////////////////////////////////////////

Future<List<ThreadComments>> fetchThreadComments(int ThreadIdentifier) async {
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  String url =
      'http://10.0.2.2:5000/api/Forum/RetrieveThreadComments?ForumThreadID=' +
          ThreadIdentifier.toString();
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUnVudGltZVRlcnJvcnMiLCJleHAiOjE2Mjg5NjkyNDcsImlzcyI6InJ1bnRpbWUudGVycm9ycyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDE7aHR0cDovL2xvY2FsaG9zdDo1MDAwIn0.MBTk3DXysmd7UxtLRuDEzLMXfUH0yeaoU8BluEnW3b0";
  HttpClientRequest request = await client.getUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.headers.set('Authorization', 'Bearer $token');
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
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUnVudGltZVRlcnJvcnMiLCJleHAiOjE2Mjg5NjkyNDcsImlzcyI6InJ1bnRpbWUudGVycm9ycyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDE7aHR0cDovL2xvY2FsaG9zdDo1MDAwIn0.MBTk3DXysmd7UxtLRuDEzLMXfUH0yeaoU8BluEnW3b0";
    final response = await http.delete(
      Uri.parse('https://10.0.2.2:5001/api/Forum/DeleteThreadComment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
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

Future<String> editForumThread(String title, String body) async {
  try {
    if (title == "") {
      throw ("Cannot Submit Empty Fields");
    }

    if (editForumThreadImg64 != "") {
      editForumThreadInputImage = editForumThreadImg64;
    }
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUnVudGltZVRlcnJvcnMiLCJleHAiOjE2Mjg5NjkyNDcsImlzcyI6InJ1bnRpbWUudGVycm9ycyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDE7aHR0cDovL2xvY2FsaG9zdDo1MDAwIn0.MBTk3DXysmd7UxtLRuDEzLMXfUH0yeaoU8BluEnW3b0";
    final response = await http.put(
      Uri.parse('https://10.0.2.2:5001/api/Forum/EditForumThread'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        "forumThreadBody": body,
        "forumThreadId": currentThreadID,
        "forumThreadTitle": title,
        "imageUrl": editForumThreadInputImage
      }),
    );
    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 100) {
      return ("Successfully Edited Forum Thread");
    } else {
      throw ("Failed Edit Forum Thread" + response.statusCode.toString());
    }
  } catch (Exception) {
    return Exception.toString();
  }
}

Future<String> editForumThreadComment(String body) async {
  try {
    if (body == "") {
      throw ("Cannot Submit Empty Comment");
    }
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUnVudGltZVRlcnJvcnMiLCJleHAiOjE2Mjg5NjkyNDcsImlzcyI6InJ1bnRpbWUudGVycm9ycyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDE7aHR0cDovL2xvY2FsaG9zdDo1MDAwIn0.MBTk3DXysmd7UxtLRuDEzLMXfUH0yeaoU8BluEnW3b0";
    final response = await http.put(
      Uri.parse('https://10.0.2.2:5001/api/Forum/EditThreadComment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        "threadCommentId": currentCommentId,
        "commentBody": body,
        "imageUrl": "image.png",
        "likes": 0,
        "dislikes": 0
      }),
    );
    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 100) {
      return ("Successfully Edited Comment");
    } else {
      throw ("Failed To Edit Comment" + response.statusCode.toString());
    }
  } catch (Exception) {
    return Exception.toString();
  }
}
