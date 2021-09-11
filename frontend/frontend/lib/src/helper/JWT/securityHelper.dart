import 'package:shared_preferences/shared_preferences.dart';

class SecurityHelper {
  void setToken(token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  setFirestoreIdToken(idToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('firestoreIdToken', idToken);
  }

  getFirestoreIdToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('firestoreIdToken');
  }

  clearPersitantTokenData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}
