import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sitecheck3/models/site_visit.dart';
import 'package:sitecheck3/services/onlinedatabase.dart';
import 'package:sitecheck3/services/visit_database.dart';
import 'package:sitecheck3/screens/visit_form.dart';
import 'package:sitecheck3/services/auth.dart';
import 'package:flutter_persistent_queue/flutter_persistent_queue.dart';

const List<String> events = ['new', 'update', 'delete'];

class SavedVisit extends StatefulWidget {
  final AuthService _auth = AuthService();
  final FirebaseAuth _auth2 = FirebaseAuth.instance;

  SavedVisit() {
    // _auth.username().then((onValue)=>_onlineDatabase.user = onValue);
  }

  @override
  _SavedVisitState createState() {
    return _SavedVisitState();
  }
}

class _SavedVisitState extends State<SavedVisit> {
  List<SiteVisit> visits;
  //For syncstatus, 1 is sync not connected, 2 is syncing, 3 is synced
  List<int> syncStatus;
  String userEmail;
  OnlineDatabase _onlineDatabase;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    userEmail = widget._auth2.currentUser.email;
    _onlineDatabase = OnlineDatabase(userEmail);
  }

  /*  Future getAllVisits() async {
    visits = await visitDB.visits();

    return visits;
  }
 */

/*   Future initialiseDB() async {
    return visitDB.initDb().then((stuff) {
      //getAllVisits();
      return stuff;
    });
  } */

  @override
  Widget build(BuildContext context) {
    //openVisitForm();
    return StreamBuilder(
        stream: _onlineDatabase.getVisitsSnapshot(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return new Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: const Text('Site Inspection'),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.add_alert),
                    tooltip: 'Add Visit',
                    onPressed: () {
                      //Open the form and update Online database
                      openVisitFormNew();
                      // updateOnlineDatabase();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    tooltip: 'Next page',
                    onPressed: () async {
                      await widget._auth.signOut();
                      /* dropDB();
                setState(() {
                  getAllVisits(); 
                }); */
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.airline_seat_recline_extra),
                    tooltip: 'Add',
                    onPressed: () => testMultiple(),
                  ),
                ],
              ),
              body: visitListWidget(snapshot),
            );
          } else if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          else
            return new Text('Loading....');
        });
  }

  Widget visitListWidget(AsyncSnapshot<dynamic> snapshot) {
    //Displays list of all visits

    return FutureBuilder(
        future: setVisitsAndSync(snapshot.data),
        builder: (context, futureSnap) {
          switch (futureSnap.connectionState) {
            case ConnectionState.waiting:
              return Text("Loading");
            default:
              if (!futureSnap.hasError) {
                if (visits == null)
                  return SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics());
                else {
                  if (visits.length == 0)
                    return SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics());
                  else {
                    return ListView.builder(
                        itemCount: visits != null ? visits.length : 0,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return ListTile(
                              title: new Text(
                                visits[index].siteId,
                                style: TextStyle(fontSize: 16),
                              ),
                              subtitle: Container(
                                child: Text(
                                    visits[index].dateofVisit.toIso8601String(),
                                    style: TextStyle(
                                        color: Colors.brown, fontSize: 12)),
                              ),
                              onTap: () {
                                openVisitFormNew(visits[index]);
                              },
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    icon: (syncStatus[index] == null)
                                        ? Icon(Icons.ac_unit)
                                        : Icon([
                                            Icons.cancel,
                                            Icons.cached,
                                            Icons.check
                                          ][syncStatus[index] - 1]),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                      ),
                                      onPressed: () async {
                                        bool result =
                                            await yesCancelAlertDialog(context);
                                        if (result == true)
                                          _onlineDatabase.deleteVisit(
                                              visits[index].entryuid);
                                      }),
                                ],
                              ));
                        });
                  }
                }
              } else
                return Text('Error' + futureSnap.error.toString());
          }
        });
  }

  openVisitFormNew([SiteVisit visitb4]) async {
    SiteVisit visit = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VisitForm(visitb4),
        ));
    if (visit != null) {
      //Potential error
      await _onlineDatabase.addVisit(visit);
      /* setState(() {
        getAllVisits();
      }); */
    }
  }

  testMultiple() async {
    List<SiteVisit> visits = [
      SiteVisit.fromList([
        '14c926t0-39dd-11ea-l39i-fff47b71598b',
        'oy066',
        '2020-01-18T11:28:30.825026',
        32323.0,
        23.0,
        323.0,
        1,
        232.0,
        323.0,
        34.0,
        1,
        1,
        323.0,
        213.0,
        23.0,
        1,
        0,
        2131.0,
        12.0,
        1,
        1,
        1,
        '',
        1
      ]),
      SiteVisit.fromList([
        '14c926t0-39dd-11ea-l66i-fff47b71598b',
        'oy066',
        '2020-01-18T11:28:30.825026',
        32323.0,
        23.0,
        323.0,
        1,
        232.0,
        323.0,
        34.0,
        1,
        1,
        323.0,
        213.0,
        23.0,
        1,
        0,
        2131.0,
        12.0,
        1,
        1,
        1,
        '',
        1
      ]),
      SiteVisit.fromList([
        '14c926t0-39dd-11ea-l3fi-fff47b71598b',
        'oy109',
        '2020-01-18T11:28:30.825026',
        32323.0,
        23.0,
        323.0,
        1,
        232.0,
        323.0,
        34.0,
        1,
        1,
        323.0,
        213.0,
        23.0,
        1,
        0,
        2131.0,
        12.0,
        1,
        1,
        1,
        '',
        1
      ]),
      SiteVisit.fromList([
        '14c926t0-39dd-11ea-l39i-fffijb71598b',
        'og666',
        '2020-01-18T11:28:30.825026',
        32323.0,
        23.0,
        323.0,
        1,
        232.0,
        323.0,
        34.0,
        1,
        1,
        323.0,
        213.0,
        23.0,
        1,
        0,
        2131.0,
        12.0,
        1,
        1,
        1,
        '',
        1
      ]),
      SiteVisit.fromList([
        '14c92y00-39dd-11ea-l39i-fff47b71598b',
        'oy010',
        '2020-01-18T11:28:30.825026',
        32323.0,
        23.0,
        323.0,
        1,
        232.0,
        323.0,
        34.0,
        1,
        1,
        323.0,
        213.0,
        23.0,
        1,
        0,
        2131.0,
        12.0,
        1,
        1,
        1,
        '',
        1
      ])
    ];

    visits.forEach((it) async => await _onlineDatabase.addVisit(it));

    /* setState(() {
      getAllVisits();
    }); */
  }

  /* dropDB() {
    visitDB.database.execute("DROP TABLE IF EXISTS visits");
    visitDB.database.execute(
        "CREATE TABLE visits(entryuid TEXT PRIMARY KEY, siteId TEXT, dateofVisit TEXT, dgCapacity REAL, genRH REAL, lastPPM REAL, dgDuePPM INTEGER, freq REAL, dgACVolts REAL, dgACLoad REAL, engOilOk INTEGER, radOk INTEGER, dieselDipLts REAL, dieselDipcm REAL, dieselGal REAL, phcnOk INTEGER, hybridOk INTEGER, dcLoad REAL, moduleNo REAL, secLtOk INTEGER, avLtOk INTEGER, janitOk INTEGER, comment TEXT, pending INTEGER)");
  }
 */
  updateOnlineDatabase() {
    setState(() {
      for (SiteVisit item in visits) {
        if (item.pending) {
          _onlineDatabase.addVisit(item);
          item.pending = false;
          print(item.siteId);
        }
      }
    });
  }

  Future<bool> setVisitsAndSync(QuerySnapshot snapshot) async {
    //This sets the sync status and visits

    //For syncstatus, 1 is sync not connected, 2 is syncing, 3 is synced

    // This gets a snapshot of the user's documents
    List<QueryDocumentSnapshot> currentDocs = snapshot.docs;

    // This converts it to a list of Visits
    visits = currentDocs.map((doc) => SiteVisit.fromMap(doc.data())).toList();
    syncStatus = new List(currentDocs.length);
    print("Inside setVisit stuck");
    //This creates the sync status
    for (var i = 0; i < currentDocs.length; i += 1) {
      //For syncstatus, 1 is sync not connected, 2 is syncing, 3 is synced

      bool fromCache = currentDocs[i].metadata.isFromCache;
      if (!fromCache) {
        // SYNC DONE
        syncStatus[i] = 3;
      } else {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            // SYNCING...
            syncStatus[i] = 2;
          }
        } on SocketException catch (_) {
          // WAITING ON CONNECTION...
          syncStatus[i] = 1;
        }
      }
    }

    // setState(() {});
    return true;
    //Future(() => true);
  }

  Future<bool> yesCancelAlertDialog(BuildContext context) async {
    // This creates a delete confirmation dialog
    bool result = false;
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop(false);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop(true);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Entry"),
      content: Text("Are you sure?"),
      actions: [
        continueButton,
        cancelButton,
      ],
    );

    // show the dialog
    result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    return result;
  }
}
