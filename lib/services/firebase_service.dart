import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/reading.dart';

class FirebaseService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<UserCredential> signIn(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> signUp(String email, String password) =>
      _auth.createUserWithEmailAndPassword(email: email, password: password);

  Future<void> signOut() => _auth.signOut();

  CollectionReference<Map<String, dynamic>> _userReadingsCol(String uid) =>
      _db.collection('readings').doc(uid).collection('entries');

  Future<void> addReading(String uid, Reading r) async {
    await _userReadingsCol(uid).add(r.toMap());
  }

  Stream<List<Reading>> readingsStream(String uid) {
    return _userReadingsCol(uid)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => Reading.fromMap(d.data())).toList());
  }

  Future<Reading?> latestReading(String uid) async {
    final q = await _userReadingsCol(uid)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();
    if (q.docs.isEmpty) return null;
    return Reading.fromMap(q.docs.first.data());
  }
}
