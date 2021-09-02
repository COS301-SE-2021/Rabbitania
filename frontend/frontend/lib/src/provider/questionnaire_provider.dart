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

    final response = await http.post(
      Uri.parse('http://10.0.2.2:5006/api/predict'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "cough": newSymptoms[0].toString(),
        "fever": newSymptoms[1].toString(),
        "sore_throat": newSymptoms[2].toString(),
        "shortness_of_breath": newSymptoms[3].toString(),
        "head_ache": newSymptoms[4].toString(),
        "gender": maleFemale,
        "test_indication": contact,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.body);
      if (response.body == "True") {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }

    // [1, 1, 0, 1, 0, 1]
  }
}
