import 'dart:async';
import 'dart:convert';
import 'dart:io';
import "dart:developer";

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../models/visit_sync_status.dart';

class FileStorage with ChangeNotifier {
  VisitSyncStatus loadedData;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/app_data.json');
  }

  loadData() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();
      if (contents != null) {
        // parse json if file was saved before
        loadedData = VisitSyncStatus.fromJson(json.decode(contents));
        notifyListeners();
      }
    } on FileSystemException catch (_) {
      // the file did not exist before
    } catch (e) {
      // error handling   
      log(e);
    }
  }

  Future<File> writeData(VisitSyncStatus data) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString(jsonEncode(data.toJson()));
  }
}
