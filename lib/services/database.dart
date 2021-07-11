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

  List<Coffee> _coffeeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Coffee(
        name: doc.get('name') ?? '',
        strength: doc.get('strength') ?? 0,
        sugars: doc.get('sugars') ?? '0'
        );
    }).toList();
  }


  Stream<List<Coffee>> get coffee {
    return coffeeCollection.snapshots()
      .map(_coffeeListFromSnapshot);
  }
}
