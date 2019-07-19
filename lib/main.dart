import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'items_view.dart';
import 'programme.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Obóz dla Klimatu 2019",
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
                      menuButton("Zarejestruj się", () async {
                        const url = 'https://forms.gle/WoVJsEhRf7QzYuxa8';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }),
                      Builder(
                          builder: (context) => menuButton("Program", () {
                                Navigator.pushNamed(context, "/programme-view");
                              })),
                      Builder(
                          builder: (context) => menuButton("Lista rzeczy", () {
                                Navigator.pushNamed(context, "/items-view");
                              })),
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget menuButton(String text, Function onPressed) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0, bottom: 20.0),
      child: Builder(
        builder: (context) {
          return RaisedButton(
              child: Text(
                text,
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
}
