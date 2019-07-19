import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/Thing.dart';

class ItemsView extends StatefulWidget {
  @override
  _ItemsViewState createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  final Map<String, bool> things = {};

  Future<Null> getSharePrefs(String key) async {
    await SharedPreferences.getInstance().then((prefs) {
      String value = prefs.getString(key);
      if (value != null && things[key] == false) {
        setState(() {
          things[key] = true;
        });
      }
    });
  }

  Future<Null> storeInput(String key, bool value) async {
    await SharedPreferences.getInstance().then((prefs) {
      setState(() {
        if (value)
          prefs.setString(key, "1");
        else
          prefs.remove(key);
        things[key] = !things[key];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Lista rzeczy")), body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('to-take').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final thing = Thing.fromSnapshot(data);
    getSharePrefs(thing.name);

    if (things[thing.name] == null) {
      things[thing.name] = false;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
            color: things[thing.name]
                ? Colors.lightGreenAccent
                : Colors.deepOrange),
        child: CheckboxListTile(
            title: Text(
              thing.polish,
              style: TextStyle(
                  color: things[thing.name] ? Colors.black : Colors.white),
            ),
            value: things[thing.name] ?? false,
            onChanged: (bool value) {
              storeInput(thing.name, value);
            }),
      ),
    );
  }
}
