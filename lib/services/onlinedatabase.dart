import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sitecheck3/models/site_visit.dart';

class OnlineDatabase {
  CollectionReference visitCollection;
  String userEmail;
  OnlineDatabase(this.userEmail) {
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
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

  Stream<List<SiteVisit>> getVisitsStream() async* {
    // To create explanatory comment

    // This gets a snapshot of the user's documents
    Stream<List<QueryDocumentSnapshot>> currentDocs =
        visitCollection.snapshots().map((event) => event.docs);

    // This converts it to a list of Visits
    await for (var objs in currentDocs) {
      var output = objs.map((e) => SiteVisit.fromMap(e.data())).toList();
      yield output;
    }
  }
}
