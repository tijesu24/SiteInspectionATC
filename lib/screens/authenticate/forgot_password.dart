import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sitecheck3/services/auth.dart';
import 'package:sitecheck3/shared/constants.dart';

class ForgotPassword extends StatefulWidget {
  final AuthService _auth;
  ForgotPassword(this._auth);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text("Forgot Password"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Email',
                  ),
                  validator: (val) =>
                      validateEmail(val) ? null : 'Enter an email',
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Send Mail',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        int status = await widget._auth.resetPassword(email);
                        createStatusDialog(status);
                        Navigator.pop(context);

                        setState(() => loading = false);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  createStatusDialog(int status) {
    // Shows dialog of status of the auth function
    String statusMessage;
    switch (status) {
      case AuthService.taskDone:
        statusMessage = 'Check your email';
        break;
      case AuthService.errorUserNotExists:
        statusMessage = 'The email address entered does not belong to a user';
        break;
      case AuthService.errorUnknown:
        statusMessage = 'An error occured';

        break;
      default:
    }
  }
}
