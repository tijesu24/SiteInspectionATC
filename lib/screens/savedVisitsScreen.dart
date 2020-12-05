import 'dart:io';

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
  String userEmail;
  OnlineDatabase _onlineDatabase;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // PersistentQueue pq =

  @override
  void initState() {
    super.initState();
    userEmail = widget._auth2.currentUser.email;
    _onlineDatabase = OnlineDatabase(userEmail);
    // widget._auth..then((value) => userEmail = value);
    // _onlineDatabase = OnlineDatabase(userEmail);

    /* pq = PersistentQueue('visitQueue' , onFlush: (list) async {
    final result = await InternetAddress.lookup('google.com');
  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    if (list[0] == events[0]) {
      await _onlineDatabase.addVisit((){
        for 
      }
  
    }} 
  // print('auto-flush\n$list');
}); */
  }

  /*  Future getAllVisits() async {
    visits = await visitDB.visits();

    return visits;
  }
 */
  _screenReturn() {
    //Displays list of all visits
    if (visits == null)
      return SingleChildScrollView(physics: AlwaysScrollableScrollPhysics());
    else {
      if (visits.length == 0)
        return SingleChildScrollView(physics: AlwaysScrollableScrollPhysics());
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
                    child: Text(visits[index].dateofVisit.toIso8601String(),
                        style: TextStyle(color: Colors.brown, fontSize: 12)),
                  ),
                  onTap: () {
                    openVisitForm(visits[index]);
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                            visits[index].pending ? Icons.cached : Icons.check),
                        onPressed: () {},
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                          ),
                          onPressed: () {
                            _onlineDatabase.deleteVisit(visits[index].entryuid);
                          }),
                    ],
                  ));
            });
      }
    }
  }

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
        stream: _onlineDatabase.getVisitsStream(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            visits = snapshot.data;

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
                      openVisitForm();
                      // updateOnlineDatabase();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz),
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
              body: _screenReturn(),
            );
          } else if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          else
            return new Text('Loading....');
        });
  }

  openVisitForm([SiteVisit visitb4]) async {
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
}
