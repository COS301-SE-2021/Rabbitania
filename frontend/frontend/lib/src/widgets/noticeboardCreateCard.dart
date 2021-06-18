
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


    return AlertDialog(
      content: Text("Successfully Uploaded New Thread"),
    );
  }
  catch(Exception)
  {
    return AlertDialog(
      content: Text("Failed due to unknown error, try again or contact an admin"),
    );
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
