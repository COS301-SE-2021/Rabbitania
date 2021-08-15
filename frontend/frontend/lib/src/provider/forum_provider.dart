import 'dart:convert';
import 'dart:io';
import 'package:frontend/src/helper/JWT/securityHelper.dart';
import 'package:frontend/src/helper/URL/urlHelper.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/widgets/Forum/forumCreateThreadCard.dart';
import 'package:frontend/src/widgets/Forum/forumEditForumThreadCard.dart';
import 'package:http/http.dart' as http;

////////////////////////////////////////////////////////////////
/// Forum Requests
///////////////////////////////////////////////////////////////

Future<List<ForumObj>> fetchForum() async {
  HttpClient client = new HttpClient();
  SecurityHelper securityHelper = new SecurityHelper();
  UserHelper loggedUser = new UserHelper();
  URLHelper urlBase = new URLHelper();
  final baseURL = await urlBase.getBaseURL();
  final baseAltURL = await urlBase.getAltBaseURL();
  final token = await securityHelper.getToken();
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
        'userID': loggedUser.getUserID(),
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
  var cid = currentForumID;
  try {
    if (currentForumID < 0) {
      throw ("Error Forum ID is Incorrect");
    }
    SecurityHelper securityHelper = new SecurityHelper();
    UserHelper loggedUser = new UserHelper();
    URLHelper url = new URLHelper();

    final baseURL = await url.getBaseURL();
    final token = await securityHelper.getToken();
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
    } else if (response.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse('https://10.0.2.2:5001/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'userID': loggedUser.getUserID(),
          'name': loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return deleteForum(cid);
      } else {
        throw new Exception("Error with Authentication");
      }
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
  UserHelper loggedUser = new UserHelper();
  URLHelper urlBase = new URLHelper();
  final baseAltURL = await urlBase.getAltBaseURL();
  final baseURL = await urlBase.getBaseURL();

  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  String url = baseAltURL +
      '/api/Forum/RetrieveForumThreads?ForumID=' +
      forumIdentifier.toString();
  SecurityHelper securityHelper = new SecurityHelper();
  final token = await securityHelper.getToken();
  HttpClientRequest request = await client.getUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.headers.set('Authorization', 'Bearer $token');

  HttpClientResponse response1 = await request.close();
  String reply = await response1.transform(utf8.decoder).join();
  //print(jsonDecode(reply));
  if (response1.statusCode == 401) {
    final authReponse = await http.post(
      Uri.parse(baseURL + '/api/Auth/Auth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        'userID': loggedUser.getUserID(),
        'name': loggedUser.getUserName()
      }),
    );
    if (authReponse.statusCode == 200) {
      Map<String, dynamic> obj = jsonDecode(authReponse.body);
      var token = '${obj['token']}';
      securityHelper.setToken(token);
      return fetchForumThreads(forumIdentifier);
    } else {
      throw new Exception("Error with Authentication");
    }
  }
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
    SecurityHelper securityHelper = new SecurityHelper();
    UserHelper loggedUser = new UserHelper();
    final token = await securityHelper.getToken();
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
    } else if (response.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse(baseURL + '/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'userID': loggedUser.getUserID(),
          'name': loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return deleteForumThread(currentThreadID);
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      throw ("Falied to delete, error code" + response.statusCode.toString());
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
    SecurityHelper securityHelper = new SecurityHelper();
    UserHelper loggedUser = new UserHelper();
    final token = await securityHelper.getToken();
    final response = await http.post(
      Uri.parse(baseURL + '/api/Forum/CreateForum'),
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
    } else if (response.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse(baseURL + '/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'userID': loggedUser.getUserID(),
          'name': loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return addNewForum(title, userID);
      } else {
        throw new Exception("Error with Authentication");
      }
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
  URLHelper url = new URLHelper();
  final baseURL = await url.getBaseURL();
  try {
    if (title == "") {
      throw ("Cannot Submit Empty Title");
    }

    if (ForumCreateImg64 != "") {
      ForumCreateInputImage = ForumCreateImg64;
    }
    SecurityHelper securityHelper = new SecurityHelper();
    UserHelper loggedUser = new UserHelper();
    final token = await securityHelper.getToken();
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
        "createdDate": "2021-08-04T13:45:13.091Z",
        "imageUrl": ForumCreateInputImage,
        "userId": userId,
        "forumId": currentForumID
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      ForumCreateImageFile = null;
      return ("Successfully uploaded new Forum Thread");
    } else if (response.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse(baseURL + '/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'userID': loggedUser.getUserID(),
          'name': loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return addNewForumThread(currentId, title, body, userId);
      } else {
        throw new Exception("Error with Authentication");
      }
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
  URLHelper url = new URLHelper();
  final baseURL = await url.getBaseURL();
  print(title);
  try {
    if (title == "") {
      throw ("Cannot Submit Empty Fields");
    }
    SecurityHelper securityHelper = new SecurityHelper();
    UserHelper loggedUser = new UserHelper();
    final token = await securityHelper.getToken();
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
      return ("Successfully uploaded new notice");
    } else if (response.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse(baseURL + '/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'userID': loggedUser.getUserID(),
          'name': loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return editNewForum(title);
      } else {
        throw new Exception("Error with Authentication");
      }
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
  URLHelper urlBase = new URLHelper();
  final baseURL = await urlBase.getBaseURL();
  final baseAltURL = await urlBase.getAltBaseURL();

  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  String url = baseAltURL +
      '/api/Forum/RetrieveThreadComments?ForumThreadID=' +
      ThreadIdentifier.toString();
  SecurityHelper securityHelper = new SecurityHelper();
  UserHelper loggedUser = new UserHelper();
  final token = await securityHelper.getToken();
  HttpClientRequest request = await client.getUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.headers.set('Authorization', 'Bearer $token');
  HttpClientResponse response1 = await request.close();
  String reply = await response1.transform(utf8.decoder).join();
  print(jsonDecode(reply));

  if (response1.statusCode == 401) {
    final authReponse = await http.post(
      Uri.parse(baseURL + '/api/Auth/Auth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        'userID': loggedUser.getUserID(),
        'name': loggedUser.getUserName()
      }),
    );
    if (authReponse.statusCode == 200) {
      Map<String, dynamic> obj = jsonDecode(authReponse.body);
      var token = '${obj['token']}';
      securityHelper.setToken(token);
      return fetchThreadComments(ThreadIdentifier);
    } else {
      throw new Exception("Error with Authentication");
    }
  }
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
  URLHelper urlBase = new URLHelper();
  final baseURL = await urlBase.getBaseURL();
  try {
    print(currentCommentId);
    if (currentCommentId < 0) {
      throw ("Error: Comment Id is invalid");
    }
    SecurityHelper securityHelper = new SecurityHelper();
    UserHelper loggedUser = new UserHelper();
    final token = await securityHelper.getToken();
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
    //print("CODE ============" + response.statusCode.toString());
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse(baseURL + '/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'userID': loggedUser.getUserID(),
          'name': loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return deleteComment(currentCommentId);
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      throw ("Failed to delete, error code" + response.statusCode.toString());
    }
  } catch (Exception) {
    return false;
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
    SecurityHelper securityHelper = new SecurityHelper();
    UserHelper loggedUser = new UserHelper();
    final token = await securityHelper.getToken();
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
    } else if (response.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse(baseURL + '/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'userID': loggedUser.getUserID(),
          'name': loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return editForumThread(title, body);
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      throw ("Failed Edit Forum Thread" + response.statusCode.toString());
    }
  } catch (Exception) {
    return Exception.toString();
  }
}

Future<String> editForumThreadComment(String body) async {
  URLHelper urlBase = new URLHelper();
  final baseURL = await urlBase.getBaseURL();
  try {
    if (body == "") {
      throw ("Cannot Submit Empty Comment");
    }
    SecurityHelper securityHelper = new SecurityHelper();
    UserHelper loggedUser = new UserHelper();
    final token = await securityHelper.getToken();
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
    } else if (response.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse(baseURL + '/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'userID': loggedUser.getUserID(),
          'name': loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return editForumThreadComment(body);
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      throw ("Failed To Edit Comment" + response.statusCode.toString());
    }
  } catch (Exception) {
    return Exception.toString();
  }
}
