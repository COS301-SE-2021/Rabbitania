import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ForumThreads {
  final List<dynamic> forumThreadList;

  ForumThreads({
    required this.forumThreadList,
  });

  factory ForumThreads.fromJson(Map<String, dynamic> json) {
    return ForumThreads(
      forumThreadList: json["forums"],
    );
  }
}

class ForumThread {
  final int forumId;
  final String forumTitle;
  final String createdDate;
  final int userId;

  ForumThread({
    required this.forumId,
    required this.forumTitle,
    required this.createdDate,
    required this.userId,
  });

  factory ForumThread.fromJson(Map<String, dynamic> json) {
    return ForumThread(
      forumId: json['forumId'],
      forumTitle: json['forumTitle'],
      createdDate: json['createdDate'],
      userId: json['userId'],
    );
  }
}

Future<List<ForumThread>> fetchForumThread() async {
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  String url =
      'http://10.0.2.2:5000/api/NoticeBoard/RetrieveNoticeBoardThreads';

  HttpClientRequest request = await client.getUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');

  HttpClientResponse response1 = await request.close();
  String reply = await response1.transform(utf8.decoder).join();

  List<dynamic> tList =
      ForumThreads.fromJson(jsonDecode(reply)).forumThreadList;

  List<ForumThread> threadObj = [];

  for (var t in tList) {
    threadObj.add(ForumThread.fromJson(t));
  }

  client.close();
  return threadObj;
}
