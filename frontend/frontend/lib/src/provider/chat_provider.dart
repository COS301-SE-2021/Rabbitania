import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/src/helper/Chat/chatHelper.dart';
import 'package:frontend/src/helper/JWT/securityHelper.dart';
import 'package:frontend/src/helper/URL/urlHelper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatProvider {
  SecurityHelper securityHelper = new SecurityHelper();
  URLHelper url = new URLHelper();
  var email = FirebaseAuth.instance.currentUser!.providerData[0].email!;

  //function to retreive AgoraID
  Future<String> getAgoraID() async {
    final baseURL = await url.getBaseURL();
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/Agora/GetAppID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      ChatHelper chatHelper = new ChatHelper();
      var key = dotenv.env['ENC_KEY'];

      var decryptedKey = chatHelper.decryptData(
        response.body,
        key.toString(),
      );
      return decryptedKey;
    } else {
      return "Agora ID was not returned: There was some error with the process.";
    }
  }
}
