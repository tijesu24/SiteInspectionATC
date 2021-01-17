import 'package:flutter/material.dart';

class BasicPage extends StatefulWidget {
  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Basic')),
        body: Container(padding: EdgeInsets.all(20), child: Text("Hi")));
  }
}
