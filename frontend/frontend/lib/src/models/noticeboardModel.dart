import 'dart:convert';
import 'dart:io';

class NoticeBoardThreads {
  final List<dynamic> threadList;

  NoticeBoardThreads({
    required this.threadList,
  });

  factory NoticeBoardThreads.fromJson(Map<String, dynamic> json) {
    return NoticeBoardThreads(
      threadList: json["noticeBoard"],
    );
  }
}

class Thread {
  final int threadId;
  final String threadTitle;
  final String threadContent;
  final int minLevel;
  final String imageUrl;
  final int permittedUserRoles;
  final int userId;

  Thread({
    required this.threadId,
    required this.threadTitle,
    required this.threadContent,
    required this.minLevel,
    required this.imageUrl,
    required this.permittedUserRoles,
    required this.userId,
  });

  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
      threadId: json['threadId'],
      threadTitle: json['threadTitle'],
      threadContent: json['threadContent'],
      minLevel: json['minLevel'],
      imageUrl: json['imageUrl'],
      permittedUserRoles: json['permittedUserRoles'],
      userId: json['userId'],
    );
  }
}

Future<List<Thread>> fetchNotice() async {

  HttpClient client = new HttpClient();
  client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
  String url ='http://10.0.2.2:5000/api/NoticeBoard/RetrieveNoticeBoardThreads';
  //Map map = { "email" : "email" , "password" : "password" };
  HttpClientRequest request = await client.getUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  //request.add(utf8.encode(json.encode(map)));
  HttpClientResponse response1 = await request.close();
  String reply = await response1.transform(utf8.decoder).join();

  print(NoticeBoardThreads.fromJson(jsonDecode(reply)).threadList);//[{everything}]
  print(NoticeBoardThreads.fromJson(jsonDecode(reply)).threadList[0]);//{singleThread}


  var test = (NoticeBoardThreads.fromJson(jsonDecode(reply)).threadList[0]);
  print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
  print(test);
  print(jsonEncode(test));

  print(Thread.fromJson(test).threadId);

  //"{threadId:}"
  //list of strings that i can jsonEncode

  //object with threadID
  //list of thread objects
  List<dynamic> tList = NoticeBoardThreads.fromJson(jsonDecode(reply)).threadList;

  print(tList[0]);

  List<Thread> threadObj = [];

  for(var t in tList)
    {
      threadObj.add(Thread.fromJson(t));
    }
  print("ENTIRE LIST");
  print(threadObj);

  return threadObj;
}