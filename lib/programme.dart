import 'package:cloud_firestore/cloud_firestore.dart';
import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:odk_app/services/current_language_service.dart';
import 'constant.dart';
import 'programme_details_view.dart';

import 'models/Programme.dart';
import 'localizations.dart' show MyLocalizations;

class ProgrammeView extends StatefulWidget {
  @override
  _ProgrammeViewState createState() => _ProgrammeViewState();
}

class _ProgrammeViewState extends State<ProgrammeView> {
  final DateFormat format = new DateFormat("EE dd.MM");

  final DateFormat shortFormat = new DateFormat("HH:mm");

  static Duration timezoneOffset = DateTime.now().timeZoneOffset;

  Duration offsetToAdd = timezoneOffset.compareTo(Duration(hours: 0)) == 0
      ? POLISH_TIMEZONE_OFFSET
      : Duration(hours: 0);

  String _currentLanguage = "en";

  onChangeLanguage() {
    CurrentLanguageService.onChangeLanguage();
  }

  _initLocale() async {
    _currentLanguage = await CurrentLanguageService.getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    _initLocale();

    return Scaffold(
      appBar: AppBar(
          title: Text(
              MyLocalizations.of(context).getTranslationByKey("programme")),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.language), onPressed: onChangeLanguage)
          ]),
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
          return _buildMainContent(context, snapshot.data.documents);
      },
    );
  }

  _buildMainContent(BuildContext context, List<DocumentSnapshot> snapshot) {
    //divide programme points into days
    Map<int, List<DocumentSnapshot>> days =
        groupBy(snapshot, (item) => item.data["date"].day);

    //sort days
    List<int> sortedKeys = days.keys.toList()
      ..sort((key1, key2) => key1.compareTo(key2));

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/programme.jpg"), fit: BoxFit.fill),
      ),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(sortedKeys.map((item) {
              return _buildDay(context, days[item], item.toString());
            }).toList()),
          )
        ],
      ),
    );
  }

  Widget _buildDay(
      BuildContext context, List<DocumentSnapshot> snapshot, String day) {
    //sort programme points within one day
    snapshot.sort((DocumentSnapshot a, DocumentSnapshot b) =>
        a.data["date"].compareTo(b.data["date"]));

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Align(
            alignment: Alignment.center,
            child: Container(
                child: Text(format.format(snapshot[0].data["date"]),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.deepPurpleAccent),
                padding: new EdgeInsets.fromLTRB(60.0, 16.0, 60.0, 16.0)),
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.only(top: 8.0),
          itemBuilder: (context, index) =>
              _buildListItem(context, snapshot[index]),
          itemCount: snapshot.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
        ),
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
                _currentLanguage == "en"
                    ? "${shortFormat.format(programme.date.add(offsetToAdd))} ${programme.name}"
                    : "${shortFormat.format(programme.date.add(offsetToAdd))} ${programme.polish}",
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
