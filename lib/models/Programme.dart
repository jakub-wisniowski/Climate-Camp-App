import 'package:cloud_firestore/cloud_firestore.dart';

class Programme {
  final String name;
  final String polish;
  final DocumentReference reference;
  final DateTime date;
  final String location;
  final int duration;

  bool checked = false;

  Programme.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['polish'] != null),
        name = map['name'],
        polish = map['polish'],
        date = map["date"],
        location = map["location"],
        duration = map["duration"];

  Programme.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
