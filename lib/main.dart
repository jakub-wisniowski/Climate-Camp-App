import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'items_view.dart';
import 'programme.dart';

void main() => runApp(MainPage());

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final navKey = new GlobalKey<NavigatorState>();

    return MaterialApp(
        title: "Obóz dla Klimatu 2019",
        navigatorKey: navKey,
        routes: <String, WidgetBuilder>{
          '/items-view': (BuildContext context) => ItemsView(),
          '/programme-view': (BuildContext context) => ProgrammeView()
        },
        home: Scaffold(
            appBar: AppBar(title: Text("Obóz dla Klimatu")),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 20.0, bottom: 20.0),
                        child: Builder(
                          builder: (context) {
                            return RaisedButton(
                                child: Text(
                                  "Zarejestruj się",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.deepPurpleAccent,
                                onPressed: () async {
                                  const url =
                                      'https://forms.gle/WoVJsEhRf7QzYuxa8';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 20.0, bottom: 20.0),
                        child: Builder(
                          builder: (context) {
                            return RaisedButton(
                                child: Text(
                                  "Program",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.deepPurpleAccent,
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/programme-view");
                                });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 20.0, bottom: 20.0),
                        child: Builder(
                          builder: (context) {
                            return RaisedButton(
                                child: Text(
                                  "Lista rzeczy",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.deepPurpleAccent,
                                onPressed: () {
                                  Navigator.pushNamed(context, "/items-view");
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
