import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:odk_app/models/Programme.dart';

class ProgrammeDetailsView extends StatelessWidget {
  Programme item;
  DateFormat format = new DateFormat("HH:mm EEEE dd.M");

  ProgrammeDetailsView({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.polish),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/item_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Colors.white70,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Center(child: Padding(
                        padding: const EdgeInsets.only(top: 40.0, left: 40.0, bottom: 20.0),
                        child: Text("Kiedy:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                      )),
                      Center(child: Padding(
                        padding: const EdgeInsets.only(top: 40.0, bottom: 20.0, left: 10.0),
                        child: Text("${format.format(item.date)}", style: TextStyle(color: Colors.black, fontSize: 30)),
                      )),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Center(child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 40.0, bottom: 20.0),
                        child: Text("Gdzie:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                      )),
                      Center(child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0),
                        child: Text("${item.location}", style: TextStyle(color: Colors.black, fontSize: 30)),
                      )),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Center(child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 40.0, bottom: 20.0),
                        child: Text("Czas trwania:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                      )),
                      Center(child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0),
                        child: Text(item.duration.toString() + " min",  style: TextStyle(color: Colors.black, fontSize: 30)),
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}
