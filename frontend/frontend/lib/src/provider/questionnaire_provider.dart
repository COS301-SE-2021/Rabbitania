import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/src/helper/URL/urlHelper.dart';
import 'package:http/http.dart' as http;

class QuestionnaireProvider {
  final firebaseEmail =
      FirebaseAuth.instance.currentUser!.providerData[0].email!;

  Future<bool> predictAI(Map<String, bool?> symptoms, var maleFemale) async {
    var newSymptoms = [];
    var contact = "Other";
    for (var i = 0; i < symptoms.length; i++) {
      if (symptoms.entries.elementAt(i).value == true) {
        newSymptoms.add(1);
      } else {
        newSymptoms.add(0);
      }
    }
    if (newSymptoms.last == 0) {
      contact = "Other";
    } else {
      contact = "Contact with confirmed";
    }

    URLHelper url = new URLHelper();

    final response = await http.post(
      Uri.parse('http://127.0.0.1:5006/api/predict'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "cough": newSymptoms[0],
        "fever": newSymptoms[1],
        "sore_throat": newSymptoms[2],
        "shortness_of_breath": newSymptoms[3],
        "head_ache": newSymptoms[4],
        "gender": maleFemale,
        "test_indication": contact,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      print("good it works!");
      return (true);
    }

    // [1, 1, 0, 1, 0, 1]

    return false;
  }
}
