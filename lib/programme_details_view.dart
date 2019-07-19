import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:odk_app/localizations.dart';
import 'package:odk_app/models/Programme.dart';
import 'package:odk_app/services/current_language_service.dart';

class ProgrammeDetailsView extends StatefulWidget {
  final Programme item;

  @override
  _ProgrammeDetailsViewState createState() => _ProgrammeDetailsViewState(item);

  ProgrammeDetailsView({Key key, @required this.item}) : super(key: key);
}

class _ProgrammeDetailsViewState extends State<ProgrammeDetailsView> {
  final Programme item;
  final DateFormat format = new DateFormat("HH:mm dd.MM");

  String _currentLanguage;

  _ProgrammeDetailsViewState(this.item) : super();

  onChangeLanguage() {
    CurrentLanguageService.onChangeLanguage();
  }

  _initLocale() async {
    _currentLanguage = await CurrentLanguageService.getLanguage();
  }

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
    _initLocale();

    return Scaffold(
      appBar: AppBar(
        title: _currentLanguage == "en" ? Text(item.name) : Text(item.polish),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.language),
            onPressed: onChangeLanguage,
          )
        ],
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
                        MyLocalizations.of(context).getTranslationByKey("when"),
                        "${format.format(item.date)}",
                        20.0,
                        40.0),
                    Divider(),
                    rowElement(
                        MyLocalizations.of(context)
                            .getTranslationByKey("where"),
                        "${item.location}",
                        20.0,
                        0.0),
                    Divider(),
                    rowElement(
                        MyLocalizations.of(context)
                            .getTranslationByKey("duration"),
                        item.duration.toString() + " min",
                        40.0,
                        0.0),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
