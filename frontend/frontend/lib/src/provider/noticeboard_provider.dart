import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/src/helper/URL/urlHelper.dart';
import 'package:frontend/src/screens/Noticeboard/noticeSingleScreen.dart';
import 'package:frontend/src/widgets/Noticeboard/noticeboardCreateCard.dart';
import 'package:frontend/src/widgets/Noticeboard/noticeboardEditCard.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/src/models/Noticeboard/noticeboardModel.dart';

final fireBaseEmail = FirebaseAuth.instance.currentUser!.providerData[0].email!;
URLHelper url = new URLHelper();

Future<List<Thread>> fetchNotice() async {
  final token = await FirebaseAuth.instance.currentUser!.getIdToken();
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);

  String url =
      'https://rabbitania-runtimeterrors.herokuapp.com/api/NoticeBoard/RetrieveNoticeBoardThreads';
  HttpClientRequest request = await client.getUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.headers.set('Authorization', 'Bearer $token');
  HttpClientResponse response1 = await request.close();
  String reply = await response1.transform(utf8.decoder).join();

  List<dynamic> tList =
      NoticeBoardThreads.fromJson(jsonDecode(reply)).threadList;

  List<Thread> threadObj = [];

  for (var t in tList) {
    threadObj.add(Thread.fromJson(t));
  }
  client.close();
  return threadObj;
}

Future<bool> deleteThread(int threadID) async {
  final token = await FirebaseAuth.instance.currentUser!.getIdToken();
  try {
    if (threadID < 0) {
      throw ("Error Thread ID is Incorrect");
    }
    final response = await http.delete(
      Uri.parse(
          'https://rabbitania-runtimeterrors.herokuapp.com/api/NoticeBoard/DeleteNoticeBoardThread'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'threadId': threadID,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      throw ("Failed to delete, error code" + response.statusCode.toString());
    }
  } catch (Exception) {
    return false;
  }
}

Future<String> addNewThread(
    String title, String content, int noticeboardCreatorId) async {
  final token = await FirebaseAuth.instance.currentUser!.getIdToken();
  try {
    if (title == "" || content == "") {
      throw ("Cannot Submit Empty Fields");
    }

    if (noticeboardCreateImg64 != "") {
      noticeboardCreateInputImage = noticeboardCreateImg64;
    }
    final response = await http.post(
      Uri.parse('https://rabbitania-runtimeterrors.herokuapp.com/api/NoticeBoard/AddNoticeBoardThread'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'userId': noticeboardCreatorId,
        'threadTitle': title,
        'threadContent': content,
        'minLevel': 0,
        'imageUrl': noticeboardCreateInputImage,
        'permittedUserRoles': 0,
        'icon1': 0,
        'icon2': 0,
        'icon3': 0,
        'icon4': 0
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return ("Successfully uploaded new notice");
    } else {
      throw ("Failed to create new thread error" +
          response.statusCode.toString());
    }
  } catch (Exception) {
    return ("Error: " + Exception.toString());
  }
}

Future<String> increaseEmoji(String emoji) async {
  final token = await FirebaseAuth.instance.currentUser!.getIdToken();
  try {
    final response = await http.put(
      Uri.parse('https://rabbitania-runtimeterrors.herokuapp.com/api/NoticeBoard/IncreaseEmoji'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        "emojiUtf": emoji.toString(),
        "noticeboardId": noticeID
      }),
    );
    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 100) {
      return "Successfuly updated emoji";
    } else {
      throw ("Failed to create new thread error" +
          response.statusCode.toString());
    }
  } catch (Exception) {
    return Exception.toString();
  }
}

Future<String> decreaseEmoji(String emoji) async {
  final token = await FirebaseAuth.instance.currentUser!.getIdToken();
  try {
    final response = await http.put(
      Uri.parse('https://rabbitania-runtimeterrors.herokuapp.com/api/NoticeBoard/DecreaseEmoji'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        "emojiUtf": emoji.toString(),
        "noticeboardId": noticeID
      }),
    );
    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 100) {
      return "Successfuly updated emoji";
    } else {
      throw ("Failed to create new thread error" +
          response.statusCode.toString());
    }
  } catch (Exception) {
    return Exception.toString();
  }
}

Future<String> editNoticeboardThread(
    String title, String content, int noticeboardEditId) async {
  final token = await FirebaseAuth.instance.currentUser!.getIdToken();
  try {
    if (title == "" || content == "") {
      throw ("Cannot Submit Empty Fields");
    }

    if (noticeboardEditImg64 != "") {
      noticeboardEditInputImage = noticeboardEditImg64;
    }
    final response = await http.put(
      Uri.parse('https://rabbitania-runtimeterrors.herokuapp.com/api/NoticeBoard/EditNoticeBoardThread'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'threadId': noticeID,
        'threadTitle': title,
        'threadContent': content,
        'minLevel': 0,
        'imageUrl': noticeboardEditInputImage,
        'permittedUserRoles': 0,
        'userId': noticeboardEditId
      }),
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
