import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/usermodel.dart';

class Firebasehelper {
  Firebasehelper._();
  static final Firebasehelper firebasehelper = Firebasehelper._();

  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference? collectionReference;

  initdb() async {
    collectionReference = firebaseFirestore.collection('users');
  }

  insertdb({
    required Usermodel data,
  }) async {
    initdb();

    Map<String, dynamic> users = {
      'username': data.username,
      'password': data.password,
      "email": data.email,
      'role': data.role
    };
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection('counter').doc('emp_counter').get();
    Map myid = documentSnapshot.data() as Map;

    int fetchedid = myid['id'];

    await collectionReference!.doc(fetchedid.toString()).set(users);
    await firebaseFirestore
        .collection('counter')
        .doc('emp_counter')
        .update({'id': ++fetchedid});
  }

  deletedata({required String id}) async {
    await initdb();
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection('counter').doc('emp_counter').get();
    Map myid = documentSnapshot.data() as Map;

    int fetchedid = myid['id'];

    await collectionReference!.doc(id).delete();

    await firebaseFirestore
        .collection('counter')
        .doc('emp_counter')
        .update({'id': --fetchedid});
  }

  updatedata({required Usermodel data, required String id}) async {
    initdb();

    Map<String, dynamic> users = {
      'username': data.username,
      "email": data.email,
      'role': data.role
    };

    await collectionReference!.doc(id).update(users);
  }
}
