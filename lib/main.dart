import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sitecheck3/models/user.dart';
import 'package:sitecheck3/services/auth.dart';
import 'gate.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:webview_flutter/webview_flutter.dart';

void main() {
  //debugPaintSizeEnabled = true;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Site Visit',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          // Initialize FlutterFire
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return Text("SomethingWentWrong");
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return buildUserGateStream();
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Text("Loading");
          },
        ));
  }

  //Because I want to add the futurebuilder, it will make the number of columns to inrease indefinitely.
  //So, I'm separating it.
  StreamProvider<User> buildUserGateStream() {
    return StreamProvider.value(
      value: AuthService().user,
      child: Gateway(),
    );
  }
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
