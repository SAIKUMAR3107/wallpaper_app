import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServices{
  //instance of authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //Login Functionality
  Future<UserCredential> loginWithEmailPassword(String email,String password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      // save user info if it doesn't already exist
      _firestore.collection("Users").doc(userCredential.user?.uid).set(
        {
          'uid' : userCredential.user?.uid,
          "email" : email
        }
      );

      return userCredential;
    }on FirebaseAuthException catch(e){
      throw Exception(e);
    }
  }

  //register Functionality
  Future<UserCredential> registerWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      //save user into a separate doc
      _firestore.collection("Users").doc(userCredential.user?.uid).set(
        {
          'uid' : userCredential.user?.uid,
          "email" : email
        }
      );
      return userCredential;
    }on  FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }
}