import 'package:flutter/material.dart';
import 'package:sitecheck3/services/auth.dart';
import 'package:sitecheck3/shared/constants.dart';
import 'package:sitecheck3/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            // backgroundColor: Colors.brown[100],
            appBar: AppBar(
              // backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Register'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'email'),
                        validator: (val) =>
                            validateEmail(val.trim()) ? null : 'Enter an email',
                        onChanged: (val) {
                          setState(() => email = val.trim());
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'password'),
                        obscureText: true,
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                          color: Colors.pink[400],
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Please supply a valid email';
                                });
                              }
                            }
                          }),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
