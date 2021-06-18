
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/noticeboardCreateThread.dart';

var titleInput = "";
var contextInput = "";

class NoticeboardThreadCard extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Center(
      child:ListView(
          children: <Widget>[
            Card(
              color: Color.fromRGBO(57, 57, 57, 25),
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)
              ),
              clipBehavior: Clip.antiAlias,
              elevation: 10,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                  ),
                  TextFormField(
                    controller: contentController,
                  ),
                  TextButton(
                    // When the user presses the button, show an alert dialog containing
                    // the text that the user has entered into the text field.
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          titleInput = titleController.text;
                          contextInput = contentController.text;
                          return addNewThread(titleController.text,contentController.text);
                        },
                      );
                    },
                    child: Icon(Icons.control_point),
                  ),
                ],
              ),
            ),
          ]
      ),
    );
  }
}


Widget addNewThread(String title, String content)
{
  try{
    if(title==""||content=="")
      {
        throw("Cannot Submit Empty fields");
      }
    else{

      Future<bool> flag = connectAndGet();

      // ignore: unrelated_type_equality_checks
      if(flag == true)
        {
          return AlertDialog(
            content: Text("Successfully Uploaded New Thread"),
          );
        }
      else
        {
          throw("When submitting the request an error occurred");
        }
    }
  }
  catch(Exception)
  {
    return AlertDialog(
      content: Text(Exception.toString()),
    );
  }


}

Future<bool> connectAndGet() async {
  try {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
    String url = 'http://10.0.2.2:5000/api/';
    //Map map = { "email" : "email" , "password" : "password" };
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    //request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response1 = await request.close();
    String reply = await response1.transform(utf8.decoder).join();
    return true;
  }
  catch(Exception)
  {
    return false;
  }

}



// class ImageInputAdapter {
//   /// Initialize from either a URL or a file, but not both.
//   ImageInputAdapter({
//     required this.file,
//     required this.url
//   }) : assert(file != null || url != null), assert(file != null && url == null), assert(file == null && url != null);
//
//   /// An image file
//   final File file;
//   /// A direct link to the remote image
//   final String url;
//
//   /// Render the image from a file or from a remote source.
//   Widget widgetize() {
//     if (file != null) {
//       return Image.file(file);
//     } else {
//       return FadeInImage(
//         image: NetworkImage(url),
//         placeholder: AssetImage("assets/images/placeholder.png"),
//         fit: BoxFit.contain,
//       );
//     }
//   }
// }
