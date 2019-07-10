import 'package:cloud_firestore/cloud_firestore.dart';
import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'programme_details_view.dart';

import 'models/programme.dart';

class ProgrammeView extends StatefulWidget {
  @override
  _ProgrammeViewState createState() => _ProgrammeViewState();
}

class _ProgrammeViewState extends State<ProgrammeView> {
  DateFormat format = new DateFormat("EEEE dd MMM");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Program")),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("programme").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return LinearProgressIndicator();
        else
          return _buildAll(context, snapshot.data.documents);
      },
    );
  }

  Widget _dummy() {
    return Container(
      child: SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: Column(
                  children: <Widget>[
                    new Container(
                      padding:
                      EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                      color: Colors.grey,
                      child: new Text(
                        'Cast Light life style Here',
                        style: new TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ]
              )
          )
      ),
    );
  }
  Widget _buildAll(BuildContext context, List<DocumentSnapshot> snapshot) {
    Map<int, List<DocumentSnapshot>> days = groupBy(snapshot, (item) {
      DateTime date = item.data["date"];
      return date.day;
    });

    var sortedKeys = days.keys.toList()
      ..sort((key1, key2) => key1.compareTo(key2));

    return Container(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(
                  children: sortedKeys.map((item) {
                    return _buildDay(context, days[item], item.toString());
                  }).toList(),

                ),
        ),
      ),
    );
//        decoration: BoxDecoration(
//          image: DecorationImage(
//              image: AssetImage("images/programme.jpg"), fit: BoxFit.fill),
//        )

  }

  Widget _buildDay(
      BuildContext context, List<DocumentSnapshot> snapshot, String day) {
    snapshot.sort((DocumentSnapshot a, DocumentSnapshot b) {
      DateTime x = a.data["date"];
      DateTime y = b.data["date"];
      return x.compareTo(y);
    });

    return ListView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 20.0),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            format.format(snapshot[0].data["date"]),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        ...snapshot.map((data) => _buildListItem(context, data)).toList()
      ],
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final programme = Programme.fromSnapshot(data);

    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: RaisedButton(
          color: programme.date.compareTo(DateTime.now()) < 0
              ? Colors.grey
              : Colors.white,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Text(
                programme.polish,
                style: TextStyle(
                    color: programme.date.compareTo(DateTime.now()) < 0
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProgrammeDetailsView(item: programme),
              ),
            );
          },
        ),
      ),
    );
  }
}
