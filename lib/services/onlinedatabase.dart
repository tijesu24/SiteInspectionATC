import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sitecheck3/models/site_visit.dart';
import "dart:io";
import "package:tuple/tuple.dart";

class OnlineDatabase {
  CollectionReference visitCollection;
  String userEmail;
  OnlineDatabase(this.userEmail) {
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
    initDatabase();
  }

  Future<void> initDatabase() async {
    visitCollection = FirebaseFirestore.instance
        .collection('visits')
        .doc('Users')
        .collection(userEmail);
  }

  Future addVisit(SiteVisit visit) {
    return visitCollection.doc(visit.entryuid).set(visit.toMap());
  }

  List<SiteVisit> getVisitList() {
    List<SiteVisit> visits;

    visitCollection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((f) => visits.add(SiteVisit.fromMap(f.data())));
    });
    return visits;
  }

  void deleteVisit(String uuid) {
    visitCollection.doc(uuid).delete().then((_) {
      //Handle this
      print("success!");
    });
  }

  void updateVisit(SiteVisit visit) {
    try {
      visitCollection.doc(visit.entryuid).update(visit.toMap());
    } catch (e) {
      // Figure a way to present this and handle
      print(e.toString());
    }
  }

  Stream<QuerySnapshot> getVisitsSnapshot() {
    // To create explanatory comment

    // This gets a snapshot of the user's documents
    return visitCollection.snapshots(includeMetadataChanges: true);
  }
}
