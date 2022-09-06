import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future<bool> login(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print('*********login*********');
    return true;
  } catch (e) {
    print("LOGIN FAILED !!!!!!");
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password is too weak');
    } else if (e.code == 'email-already-in-use') {
      print('Account already exists for that email');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> addCoin(String id, String amount) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    var value = double.parse(amount);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Coins')
        .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      print('IN Add COIN *********');
      if (!snapshot.exists) {
        documentReference.set({'Amount': value});
        return true;
      }
      double newAmount = snapshot.data()['Amount'] + value;
      transaction.update(documentReference, {'Amount': newAmount});
      return true;
    });
    return true;
  } catch (e) {
    print('FAILED TO ADD COIN *********');
    return false;
  }
}

Future<bool> removeCoin(String id) async {
  String uid = FirebaseAuth.instance.currentUser.uid;
  FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .collection('Coins')
      .doc(id)
      .delete();
  return true;
}