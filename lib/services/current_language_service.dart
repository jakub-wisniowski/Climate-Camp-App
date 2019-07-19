import 'package:shared_preferences/shared_preferences.dart';

class CurrentLanguageService {
  static String currentLanguage;

  static Future<String> getLanguage() async {
   currentLanguage =  await SharedPreferences.getInstance()
        .then((prefs) {

          String value = prefs.getString("current-language");
          return value ?? "en";
        });

   return currentLanguage;
  }

  static Future<Null> setLanguage(String value) async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setString("current-language", value);
      currentLanguage = value;
    });
  }

  static onChangeLanguage() {
    if(currentLanguage == "en")
      setLanguage("pl");
    else
      setLanguage("en");
  }
}
