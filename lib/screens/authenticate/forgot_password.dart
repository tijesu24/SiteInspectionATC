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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'email'),
              validator: (val) => validateEmail(val) ? null : 'Enter an email',
              onChanged: (val) {
                setState(() => email = val);
              },
            ),
            SizedBox(height: 20.0),
            RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    await widget._auth.resetPassword(email).then((value) {
                      Navigator.pop(context, [true, ""]);
                    }).catchError((onError) =>
                        Navigator.pop(context, [false, onError.message]));

                    setState(() => loading = false);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
