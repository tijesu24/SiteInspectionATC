import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  String errorString;
  ErrorScreen(this.errorString);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text("Error"),
            Text("An error occurred"),
            Text("Error: $errorString")
          ],
        ),
      ),
    );
  }
}
