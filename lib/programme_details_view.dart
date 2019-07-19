import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:odk_app/models/Programme.dart';

class ProgrammeDetailsView extends StatelessWidget {
  final Programme item;
  final DateFormat format = new DateFormat("HH:mm dd.MM");

  ProgrammeDetailsView({Key key, @required this.item}) : super(key: key);

  Widget rowElement(
      String label, String value, double marginBottom, double marginTop) {
    return Row(
      children: <Widget>[
        Flexible(
            child: Padding(
          padding:
              EdgeInsets.only(top: marginTop, left: 40.0, bottom: marginBottom),
          child: Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          ),
        )),
        Flexible(
            child: Padding(
          padding:
              EdgeInsets.only(top: marginTop, bottom: marginBottom, left: 10.0),
          child:
              Text(value, style: TextStyle(color: Colors.black, fontSize: 30)),
        )),
      ],
    );
  }

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
                    rowElement(
                        "Kiedy:", "${format.format(item.date)}", 20.0, 40.0),
                    Divider(),
                    rowElement("Gdzie:", "${item.location}", 20.0, 0.0),
                    Divider(),
                    rowElement("Czas trwania:",
                        item.duration.toString() + " min", 40.0, 0.0),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
