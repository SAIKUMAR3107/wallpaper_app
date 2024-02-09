import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gallery_app/model/photos.dart';

class FavoriteService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //add Favorite images
  Future addFavoriteImage(Photos photo, int id) async {
    return _firestore
        .collection("Users")
        .doc(_auth.currentUser?.uid)
        .collection("Favorite")
        .doc(id.toString())
        .set(photo.toJson());
  }

  //remove Favorite images
  Future deleteFavoriteImage(int id) async {
    return _firestore
        .collection("Users")
        .doc(_auth.currentUser?.uid)
        .collection("Favorite")
        .doc(id.toString())
        .delete();
  }

  // Get Favorite Images from firebase
  Future<Stream<QuerySnapshot>> getAllFavoriteImages() async {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(_auth.currentUser?.uid)
        .collection("Favorite")
        .snapshots();
  }
}
