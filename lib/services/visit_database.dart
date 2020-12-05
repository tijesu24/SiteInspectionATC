import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sitecheck3/models/site_visit.dart';
import 'package:sqflite/sqflite.dart';

class SiteVisitDB {
  Database database;

  // Open the database and store the reference.
  Future initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "VisitsDB21.db");
    database = await openDatabase(
      path,
      version: 12,
      onOpen: (db) {
        print('open db');
      },
      onCreate: (Database db, int version) {
        // Run the CREATE TABLE statement on the database.
        print('create');
        return db.execute(
            "CREATE TABLE visits(entryuid TEXT PRIMARY KEY, siteId TEXT, dateofVisit TEXT, dgCapacity REAL, genRH REAL, lastPPM REAL, dgDuePPM INTEGER, freq REAL, dgACVolts REAL, dgACLoad REAL, engOilOk INTEGER, radOk INTEGER, dieselDipLts REAL, dieselDipcm REAL, dieselGal REAL, phcnOk INTEGER, hybridOk INTEGER, dcLoad REAL, moduleNo REAL, secLtOk INTEGER, avLtOk INTEGER, janitOk INTEGER, comment TEXT, pending INTEGER)");
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
    );

    return database;
  }

  Future<void> insertSiteVisit(SiteVisit visit) async {
    // Get a reference to the database.
    final Database db = database;

    // Insert the SiteVisit into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same visit is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'visits',
      visit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SiteVisit>> visits() async {
    // Get a reference to the database.

    final Database db = database;

    // Query the table for all The Visits.
    if (db != null) {
      final List<Map<String, dynamic>> maps = await db.query('visits');

      // Convert the List<Map<String, dynamic> into a List<SiteVisit>.
      dynamic visi = List.generate(maps.length, (i) {
        return SiteVisit.fromMap(maps[i]);
      });
      return visi;
    } else {
      return <SiteVisit>[];
    }
  }

  Future<void> deleteVisit(String id) async {
    // Get a reference to the database.
    final db = database;

    // Remove the visit from the Database.
    await db.delete(
      'visits',
      // Use a `where` clause to delete a specific visit.
      where: "id = ?",
      // Pass the visit's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<bool> checkIfDbExists() async {
    String path = join(await getDatabasesPath(), "VisitsDB21.db ");
    return new File(path).exists();
  }
}
