import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_dan/models/brew.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference coffeeCollection =
      FirebaseFirestore.instance.collection('coffee');

  Future updateUserData(String sugars, String name, int strength) async {
    return await coffeeCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'srength': strength,
    });
  }

  /// make sure these fields below exists in your database
  List<Coffee> _coffeeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Coffee(
        name: doc.data()['name'] ?? '',
        strength: doc.data()['strength'] ?? 0,
        sugars: doc.data()['sugars'] ?? '0'
        );
    }).toList();
  }


  Stream<List<Coffee>> get coffee {
    return coffeeCollection.snapshots()
      .map(_coffeeListFromSnapshot);
  }
}
