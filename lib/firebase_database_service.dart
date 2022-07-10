library firebase_database_service;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database_service/src/models/DataEntry.dart';


class FBDatabaseService {
  static late FirebaseFirestore _firestore;

  ///Map with the name and paths to the collections
  static Map<String, String> _collections = {};
  Map<String, String> get collections => _collections;
  /*
  static ;
  static void initialize(){
    _firestore = FirebaseFirestore.instance;
  }*/


  static void initialize({required Map<String, String> collections}){
    _firestore = FirebaseFirestore.instanceFor(app: Firebase.app());
    _collections = collections;
  }

  static void initializeFor({required FirebaseApp app, required Map<String, String> collections}){
    _firestore = FirebaseFirestore.instance;
    _collections = collections;
  }

  FBDatabaseService._privateConstructor();
  static final FBDatabaseService instance = FBDatabaseService._privateConstructor();

  ///Gets the data from the firebase by getting the key to that collection's path in collections.
  Stream<Iterable<T>> getData<T extends DataEntry>(String collectionKey) {
    String? collectionPath = collections[collectionKey];

    if(collectionPath!=null){
      return _firestore.collection(collectionPath)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => (T as T).setFromJson(doc.data())));
    }else{
      throw("The requested data collection was not defined. "
          "Try setting your '$collectionKey' collection by calling the FBDatabaseService.initialize method");
    }
  }
  /*
  static void updateSurveyAnswer({required FB_COLLECTION collection, required String id, required int increment_value}) {
    final DocumentReference docRef = _firestore.collection(collection.name).doc(id);
    docRef.update({"no_chosen": FieldValue.increment(increment_value)});
  }
   */
}
