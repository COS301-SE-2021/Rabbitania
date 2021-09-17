import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/src/helper/JWT/securityHelper.dart';
import 'package:frontend/src/helper/URL/urlHelper.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/widgets/Forum/forumCreateThreadCard.dart';
import 'package:frontend/src/widgets/Forum/forumEditForumThreadCard.dart';
import 'package:http/http.dart' as http;

// Forum Requests
class ForumProvider {
  final fireBaseEmail =
      FirebaseAuth.instance.currentUser!.providerData[0].email!;

  Future<List<ForumObj>> fetchForum() async {
    //This function gets an object from an api call and returns it in the form of a List<FormObj>
    HttpClient client = new HttpClient();
    SecurityHelper securityHelper = new SecurityHelper();
    UserHelper loggedUser = new UserHelper();
    URLHelper urlBase = new URLHelper();
    final baseURL = await urlBase.getBaseURL();
    final baseAltURL = await urlBase.getAltBaseURL();
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    String url = baseAltURL + '/api/Forum/RetrieveForums';

    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.headers.set('Authorization', 'Bearer $token');

    HttpClientResponse response1 = await request.close();
    String reply = await response1.transform(utf8.decoder).join();

    if (response1.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse(baseURL + '/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'email': fireBaseEmail,
          'name': loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return fetchForum();
      } else {
        throw new Exception("Error with Authentication");
      }
    }
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
      URLHelper url = new URLHelper();
      final baseURL = await url.getBaseURL();
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      final response = await http.delete(
        Uri.parse(baseURL + '/api/Forum/DeleteForum'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, dynamic>{
          'forumId': currentForumID,
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

  Future<String> addNewForum(String title, int userID) async {
    URLHelper url = new URLHelper();
    final baseURL = await url.getBaseURL();
    try {
      if (title == "") {
        throw ("Cannot Submit Empty Fields");
      }
      String datetime = DateTime.now().toString();
      String date = datetime.replaceAll(" ", "T");
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      final response = await http.post(
        Uri.parse(baseURL + '/api/Forum/CreateForum'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, dynamic>{
          "forumId": 0,
          "forumTitle": title,
          "createdDate": date,
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

  Future<String> editNewForum(String title) async {
    URLHelper url = new URLHelper();
    final baseURL = await url.getBaseURL();
    print(title);
    try {
      if (title == "") {
        throw ("Cannot Submit Empty Fields");
      }
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      final response = await http.put(
        Uri.parse(baseURL + '/api/Forum/EditForum'),
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
        return ("Successfully edited forum");
      } else {
        throw ("Failed to create new thread error" +
            response.statusCode.toString());
      }
    } catch (Exception) {
      return Exception.toString();
    }
  }
}

// Forum Threads

class ForumThreadProvider {
  final fireBaseEmail =
      FirebaseAuth.instance.currentUser!.providerData[0].email!;

  Future<List<ForumThread>> fetchForumThreads(int forumIdentifier) async {
    HttpClient client = new HttpClient();
    URLHelper urlBase = new URLHelper();
    final baseAltURL = await urlBase.getAltBaseURL();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    String url = baseAltURL +
        '/api/Forum/RetrieveForumThreads?ForumID=' +
        forumIdentifier.toString();
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.headers.set('Authorization', 'Bearer $token');

    HttpClientResponse response1 = await request.close();
    String reply = await response1.transform(utf8.decoder).join();

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
    URLHelper urlBase = new URLHelper();
    final baseURL = await urlBase.getBaseURL();
    try {
      if (currentThreadID < 0) {
        throw ("Error: Forum Thread ID is Incorrect");
      }
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      final response = await http.delete(
        Uri.parse(baseURL + '/api/Forum/DeleteForumThread'),
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

  Future<String> addNewForumThread(
      int currentId, String title, String body, int userId) async {
    URLHelper url = new URLHelper();
    final util = new UtilModel();
    final baseURL = await url.getBaseURL();
    try {
      if (title == "") {
        throw ("Cannot Submit Empty Title");
      }

      if (forumCreateImg64 != "") {
        forumCreateInputImage = forumCreateImg64;
      } else {
        forumCreateInputImage = util.defaultImage;
      }
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      String datetime = DateTime.now().toString();
      String date = datetime.replaceAll(" ", "T");
      final response = await http.post(
        Uri.parse(baseURL + '/api/Forum/CreateForumThread'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, dynamic>{
          "forumThreadId": 0,
          "forumThreadTitle": title,
          "forumThreadBody": body,
          "createdDate": date,
          "imageUrl": forumCreateInputImage,
          "userId": userId,
          "forumId": currentForumID
        }),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        forumCreateImageFile = null;
        return ("Successfully uploaded new Forum Thread");
      } else {
        forumCreateImageFile = null;
        throw ("Failed to create new thread error" +
            response.statusCode.toString());
      }
    } catch (Exception) {
      forumCreateImageFile = null;
      return ("Error: " + Exception.toString());
    }
  }

  Future<String> addNewForumThreadNLP(
      int currentId, String title, String body, int userId) async {
    URLHelper url = new URLHelper();
    final util = new UtilModel();
    final baseURL = await url.getBaseURL();
    try {
      if (title == "") {
        throw ("Cannot Submit Empty Title");
      }

      if (forumCreateImg64 != "") {
        forumCreateInputImage = forumCreateImg64;
      } else {
        forumCreateInputImage = util.defaultImage;
      }
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      String datetime = DateTime.now().toString();
      String date = datetime.replaceAll(" ", "T");

      final response = await http.post(
        Uri.parse(baseURL + '/api/Forum/CreateForumThreadAPI'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, dynamic>{
          "forumThreadId": 0,
          "forumThreadTitle": title,
          "forumThreadBody": body,
          "createdDate": date,
          "imageUrl": forumCreateInputImage,
          "userId": userId,
          "forumId": currentForumID
        }),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        forumCreateImageFile = null;

        if (response.body == "true") {
          return (response.body.toString());
        } else {
          return ("Successfully uploaded new Forum Thread");
        }
      } else {
        forumCreateImageFile = null;
        throw ("Failed to create new thread error" +
            response.statusCode.toString());
      }
    } catch (Exception) {
      forumCreateImageFile = null;
      return ("Error: " + Exception.toString());
    }
  }

  Future<String> editForumThread(String title, String body) async {
    URLHelper urlBase = new URLHelper();
    final baseURL = await urlBase.getBaseURL();
    try {
      if (title == "") {
        throw ("Cannot Submit Empty Fields");
      }

      if (editForumThreadImg64 != "") {
        editForumThreadInputImage = editForumThreadImg64;
      }

      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      final response = await http.put(
        Uri.parse(baseURL + '/api/Forum/EditForumThread'),
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
}

// ForumThreadComments

class ForumThreadCommentProvider {
  final fireBaseEmail =
      FirebaseAuth.instance.currentUser!.providerData[0].email!;
  Future<List<ThreadComments>> fetchThreadComments(int threadIdentifier) async {
    URLHelper urlBase = new URLHelper();
    final baseAltURL = await urlBase.getAltBaseURL();

    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    String url = baseAltURL +
        '/api/Forum/RetrieveThreadComments?ForumThreadID=' +
        threadIdentifier.toString();
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.headers.set('Authorization', 'Bearer $token');
    HttpClientResponse response1 = await request.close();
    String reply = await response1.transform(utf8.decoder).join();
    print(jsonDecode(reply));

    List? cList =
        ForumThreadComments.fromJson(jsonDecode(reply)).forumCommentsList;

    List<ThreadComments> commentObj = [];

    if (cList != null) {
      for (var t in cList) {
        commentObj.add(ThreadComments.fromJson(t));
      }

      client.close();
      return commentObj;
    } else {
      return commentObj;
    }
  }

  Future<bool> deleteComment(int currentCommentId) async {
    URLHelper urlBase = new URLHelper();
    final baseURL = await urlBase.getBaseURL();
    try {
      print(currentCommentId);
      if (currentCommentId < 0) {
        throw ("Error: Comment Id is invalid");
      }

      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      final response = await http.delete(
        Uri.parse(baseURL + '/api/Forum/DeleteThreadComment'),
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
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        throw ("Failed to delete, error code" + response.statusCode.toString());
      }
    } catch (Exception) {
      return false;
    }
  }

  Future<String> editForumThreadComment(String body) async {
    URLHelper urlBase = new URLHelper();
    final baseURL = await urlBase.getBaseURL();
    try {
      if (body == "") {
        throw ("Cannot Submit Empty Comment");
      }

      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      final response = await http.put(
        Uri.parse(baseURL + '/api/Forum/EditThreadComment'),
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

  Future<String> addNewComment(String comment, int userId) async {
    URLHelper urlBase = new URLHelper();
    final baseURL = await urlBase.getBaseURL();
    try {
      if (comment == "") {
        throw ("Cannot Submit Empty Fields");
      }

      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      String datetime = DateTime.now().toString();
      String date = datetime.replaceAll(" ", "T");
      final response = await http.post(
        Uri.parse(baseURL + '/api/Forum/CreateThreadComment'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, dynamic>{
          "threadCommentId": 0,
          "commentBody": comment,
          "createdDate": date,
          "imageUrl": "string",
          "likes": 0,
          "dislikes": 0,
          "userId": userId,
          "forumThreadId": currentThreadID
        }),
      );
      if (response.statusCode == 201 ||
          response.statusCode == 200 ||
          response.statusCode == 100) {
        return ("Success");
      } else {
        throw ("Failed to Send Message" + response.statusCode.toString());
      }
    } catch (Exception) {
      return ("Error: " + Exception.toString());
    }
  }
}
