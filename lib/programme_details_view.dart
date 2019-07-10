import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:odk_app/models/programme.dart';

class ProgrammeDetailsView extends StatelessWidget {
  Programme item;
  DateFormat format = new DateFormat("EEEE dd MMM hh:mm");

  ProgrammeDetailsView({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.polish),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Row(
              children: <Widget>[
                Center(child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, left: 40.0, bottom: 40.0),
                  child: Text("Gdzie:", style: TextStyle(fontWeight: FontWeight.bold),),
                )),
                Center(child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40.0, left: 10.0),
                  child: Text("${item.location}"),
                )),
              ],
            ),
          ),
          Card(
            child: Row(
              children: <Widget>[
                Center(child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, left: 40.0, bottom: 40.0),
                  child: Text("Kiedy:", style: TextStyle(fontWeight: FontWeight.bold),),
                )),
                Center(child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40.0, left: 10.0),
                  child: Text("${format.format(item.date)}"),
                )),
              ],
            ),
          ),
          Card(
            child: Row(
              children: <Widget>[
                Center(child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, left: 40.0, bottom: 40.0),
                  child: Text("Czas trwania:", style: TextStyle(fontWeight: FontWeight.bold),),
                )),
                Center(child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40.0, left: 10.0),
                  child: Text(item.duration.toString() + " min"),
                )),
              ],
            ),
          ),
        ]
      ),
    );
  }
}
