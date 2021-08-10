import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

//GLOBAL VARIABLES
var currentForumID = -1;
var currentForumName = "ForumName";
var currentThreadID = -1;
var currentThreadName = "ThreadName";
var currentThreadBody = "Body";
var currentCommentId = -1;
var currentCommentBody = "Body";
//

////////////////////////////////////////////////////////////////
/// Forum Getting Forums
///////////////////////////////////////////////////////////////
class ForumObjs {
  final List<dynamic> forumThreadList;

  ForumObjs({
    required this.forumThreadList,
  });

  factory ForumObjs.fromJson(Map<String, dynamic> json) {
    return ForumObjs(
      forumThreadList: json["forums"],
    );
  }
}

class ForumObj {
  final int forumId;
  final String forumTitle;
  final String createdDate;
  final int userId;

  ForumObj({
    required this.forumId,
    required this.forumTitle,
    required this.createdDate,
    required this.userId,
  });

  factory ForumObj.fromJson(Map<String, dynamic> json) {
    return ForumObj(
      forumId: json['forumId'],
      forumTitle: json['forumTitle'],
      createdDate: json['createdDate'],
      userId: json['userId'],
    );
  }
}

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
/// Forum Getting Forum Threads
///////////////////////////////////////////////////////////////

class ForumThreads {
  final List<dynamic>? forumThreadList;

  ForumThreads({
    required this.forumThreadList,
  });

  factory ForumThreads.fromJson(Map<String, dynamic> json) {
    return ForumThreads(
      forumThreadList: json["forumThreads"],
    );
  }
}

class ForumThread {
  final int forumThreadId;
  final String forumThreadTitle;
  final String forumThreadBody;
  final String createdDate;
  final String imageURL;
  final int forumId;
  final String? forum;
  final int userId;
  final String? user;

  ForumThread({
    required this.forumThreadId,
    required this.forumThreadTitle,
    required this.forumThreadBody,
    required this.createdDate,
    required this.imageURL,
    required this.forumId,
    required this.forum,
    required this.userId,
    required this.user,
  });

  factory ForumThread.fromJson(Map<String, dynamic> json) {
    return ForumThread(
      forumThreadId: json['forumThreadId'],
      forumThreadTitle: json['forumThreadTitle'],
      forumThreadBody: json['forumThreadBody'],
      createdDate: json['createdDate'],
      imageURL: json['imageURL'],
      forumId: json['forumId'],
      forum: json['forum'],
      userId: json['userId'],
      user: json['user'],
    );
  }
}

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
  print(jsonDecode(reply));

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

//////////////////////////
///ForumThreadComments:
/////////////////////////

class ForumThreadComments {
  final List<dynamic>? forumCommentsList;

  ForumThreadComments({
    required this.forumCommentsList,
  });

  factory ForumThreadComments.fromJson(Map<String, dynamic> json) {
    return ForumThreadComments(
      forumCommentsList: json["threadComments"],
    );
  }
}

class ThreadComments {
  final int threadCommentId;
  final String commentBody;
  final String createdDate;
  final String imageURL;
  final int likes;
  final int dislikes;
  final String userName;
  final String profilePicture;
  final int forumThreadId;
  final String? forumThread;
  final int userId;
  final String? user;

  ThreadComments(
      {required this.threadCommentId,
      required this.commentBody,
      required this.createdDate,
      required this.imageURL,
      required this.likes,
      required this.dislikes,
      required this.userName,
      required this.profilePicture,
      required this.forumThreadId,
      required this.forumThread,
      required this.userId,
      required this.user});

  factory ThreadComments.fromJson(Map<String, dynamic> json) {
    return ThreadComments(
        threadCommentId: json['threadCommentId'],
        commentBody: json['commentBody'],
        createdDate: json['createdDate'],
        imageURL: json['imageURL'],
        likes: json['likes'],
        dislikes: json['dislikes'],
        userName: json['userName'],
        profilePicture: json['profilePicture'],
        forumThreadId: json['forumThreadId'],
        forumThread: json['forumThread'],
        userId: json['userId'],
        user: json['user']);
  }
}

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
