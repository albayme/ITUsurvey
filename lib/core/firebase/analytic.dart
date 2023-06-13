import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalytic {
  Future<void> setUser(String userID) async {
    await FirebaseAnalytics.instance.setUserId(id: userID);
  }

  Future<void> loginEvent(String method) async {
    await FirebaseAnalytics.instance.logLogin(loginMethod: method);
  }

  Future<void> registerEvent(String method) async {
    await FirebaseAnalytics.instance.logSignUp(signUpMethod: method);
  }

  Future<void> startQuizEvent(int size) async {
    await FirebaseAnalytics.instance
        .logEvent(name: "start_quiz", parameters: {"deck_size": size});
  }

  Future<void> selectLanguageEvent(String lang) async {
    await FirebaseAnalytics.instance
        .logEvent(name: "select_language", parameters: {"lang": lang});
  }
}
