import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:odk_app/services/current_language_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'items_view.dart';
import 'programme.dart';

import 'initialize_i18n.dart' show initializeI18n;
import 'constant.dart' show languages;
import 'localizations.dart' show MyLocalizations, MyLocalizationsDelegate;


void main() async {
  Map<String, Map<String, String>> localizedValues = await initializeI18n();
  runApp(App(localizedValues));
}

class App extends StatefulWidget {
  final Map<String, Map<String, String>> localizedValues;

  App(this.localizedValues);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  String _locale = "en";

  _initLocale() async {
    _locale = await CurrentLanguageService.getLanguage();
    setState(() {});
  }

  onChangeLanguage() {
    CurrentLanguageService.onChangeLanguage();
  }

  @override
  Widget build(BuildContext context) {
    _initLocale();
    return new MaterialApp(
        locale: Locale(_locale),
        localizationsDelegates: [
          MyLocalizationsDelegate(widget.localizedValues),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: languages.map((language) => Locale(language, '')),
    routes: <String, WidgetBuilder>{
          '/items-view': (BuildContext context) => ItemsView(),
          '/programme-view': (BuildContext context) => ProgrammeView()
        },
        home: AppBody(this.onChangeLanguage));
  }
}


class AppBody extends StatelessWidget {
  final VoidCallback onChangeLanguage;

  AppBody(this.onChangeLanguage);

  Widget _menuButton(String text, Function onPressed) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0, bottom: 20.0),
      child: Builder(
        builder: (context) {
          return RaisedButton(
              child: Text(
                MyLocalizations.of(context).getTranslationByKey(text),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              shape: new RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white30, width: 3),
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Colors.deepPurpleAccent,
              padding: EdgeInsets.all(20.0),
              onPressed: onPressed);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                Text(MyLocalizations.of(context).getTranslationByKey('title')),
        actions: <Widget>[IconButton(icon: Icon(Icons.language),onPressed: onChangeLanguage,)],),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/main_bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 50.0, bottom: 50.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _menuButton('register', () async {
                    const url = 'https://forms.gle/WoVJsEhRf7QzYuxa8';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  }),
                  Builder(
                      builder: (context) => _menuButton('programme', () {
                            Navigator.pushNamed(context, "/programme-view");
                          })),
                  Builder(
                      builder: (context) => _menuButton('checklist', () {
                            Navigator.pushNamed(context, "/items-view");
                          }))
                ],
              ),
            ),
          ),
        ));
  }
}
