import 'package:cloud_firestore/cloud_firestore.dart';

class Thing {
  final String name;
  final String polish;
  final DocumentReference reference;

  bool checked = false;

  Thing.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['polish'] != null),
        name = map['name'],
        polish = map['polish'];

  Thing.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}