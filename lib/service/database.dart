import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireball/models/ahru.dart';
import 'package:fireball/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  late final String uid;
  DatabaseService({required this.uid});

  final CollectionReference ahrumikiCollection =
      FirebaseFirestore.instance.collection('Ahrumiki');

  Future updateUserData(String sugars, String name, int strength) async {
    return await ahrumikiCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  Iterable<Ahru> _ahruListFromSnapShot(QuerySnapshot snapshots) {
    return snapshots.docs.map((doc) {
      return Ahru(
        name: (doc.data() as Map<String, dynamic>)['name'] ?? ' ',
        sugars: (doc.data() as Map<String, dynamic>)['sugars'] ?? ' ',
        strength: (doc.data() as Map<String, dynamic>)['strength'] ?? 0,
      );
    }).toList();
  }

  // List<Ahru> _ahruListFromSnapShot(QuerySnapshot snapshots) {
  //   return snapshots.docs.map((doc) {
  //     return Ahru(name: name, sugars: sugars, strength: strength);
  //   });
  // }
  UserData _userDataFromSnapShot(DocumentSnapshot<Object?> snapshots) {
    // return UserData(
    //     uid: uid,
    //     name: snapshots.data()['name'],
    //     sugars: snapshots.data['sugars'],
    //     strength: snapshots.data['strength']);
    var data = snapshots.data() as Map<String, dynamic>?;
    return UserData(
      uid: uid,
      name: data!['name'],
      sugars: data!['sugars'],
      strength: data!['strength'],
    );
  }

  Stream<Iterable<Ahru>> get ahru {
    return ahrumikiCollection.snapshots().map(_ahruListFromSnapShot);
  }

  Stream<UserData> get userData {
    return ahrumikiCollection.doc(uid).snapshots().map(
        _userDataFromSnapShot); //as DocumentSnapshot<Object?> Function(DocumentSnapshot<Object?> event));
  }
}
