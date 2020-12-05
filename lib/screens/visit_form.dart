import 'package:flutter/material.dart';
import '../models/site_visit.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class VisitForm extends StatefulWidget {
  final SiteVisit visit;

  VisitForm([SiteVisit input]): visit =  input ??  SiteVisit();
  
  

  @override
  VisitFormState createState() => VisitFormState();
}

class VisitFormState extends State<VisitForm> {
  final _formKey = GlobalKey<FormState>();
   SiteVisit _thisVisit;
   

  int dgPPMRadBtn = -1;
  int engOilRadBtn = -1;
  int radiatorRadBtn = -1;
  int phcnRadBtn = -1;
  int hybridRadBtn = -1;
  int secLtRadBtn = 0;
  int aviLtRadBtn = 0;
  int janitoRadBtn = -1;

//I use these values in my validator function
//If the value is false, there is a red boundary around the rad
//button group
  bool dgPPMRadBtnValid = true;
  bool engOilRadBtnValid = true;
  bool radiatorRadBtnValid = true;
  bool phcnRadBtnValid = true;
  bool hybridRadBtnValid = true;
  bool secLtRadBtnValid = true;
  bool aviLtRadBtnValid = true;
  bool janitoRadBtnValid = true;

  String fillErrorMessage = 'Please fill this field';
  String numErrorMessage = 'Please enter a number';

  TextStyle textStyle = TextStyle(fontSize: 16.0);
  TextEditingController dateCtl = TextEditingController();

  @override
          void initState() {
                super.initState();
                _thisVisit = this.widget.visit;
                dgPPMRadBtn = booltoInt(_thisVisit.dgDuePPM);
                engOilRadBtn = booltoInt(_thisVisit.engOilOk);
                radiatorRadBtn = booltoInt(_thisVisit.radOk);
                phcnRadBtn = booltoInt(_thisVisit.phcnOk);
                hybridRadBtn = booltoInt(_thisVisit.hybridOk);
                secLtRadBtn = _thisVisit.secLtOk ?? -1;
                aviLtRadBtn = _thisVisit.avLtOk ??-1;
                janitoRadBtn = booltoInt(_thisVisit.janitOk);
                
                dateCtl.text =  _thisVisit.dateofVisit != null? _thisVisit.dateofVisit.toIso8601String() : 
                DateTime.now().toIso8601String();
          }

  

    Widget setUp(BuildContext context){
      return  Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  TextFormField(
                      //site ID
                      initialValue: _thisVisit.siteId,
                      decoration: InputDecoration(labelText: 'Site Id'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter site ID';
                        }
                        return null;
                      },
                      onSaved: (val) =>
                          setState(() => _thisVisit.siteId = val.trim())),

                  TextFormField(
                      controller: dateCtl,
                      decoration: InputDecoration(
                        labelText: "Date of visit",
                        hintText: "Ex. Insert your dob",
                      ),
                      onTap: () async {
                        DateTime date = DateTime.now();
                        FocusScope.of(context).requestFocus(new FocusNode());

                        date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now());

                        dateCtl.text = date.toIso8601String();
                      }),

                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                            //DG Capacity
                            initialValue: _thisVisit.dgCapacity != null 
                                ? _thisVisit.dgCapacity.toString() : '',
                            decoration:
                                InputDecoration(labelText: 'DG Capacity'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return fillErrorMessage;
                              }
                              if (double.tryParse(value) == null) {
                                return numErrorMessage;
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onSaved: (val) => setState(() =>
                                _thisVisit.dgCapacity = double.tryParse(val))),
                      ),
                      Expanded(flex: 1, child: Text('KVA', style: textStyle))
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                            //Gen RH
                            initialValue: _thisVisit.genRH!= null 
                                ? _thisVisit.genRH.toString() : '',
                            decoration:
                                InputDecoration(labelText: 'Gen Run Hour'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return fillErrorMessage;
                              }
                              if (double.tryParse(value) == null) {
                                return numErrorMessage;
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onSaved: (val) => setState(
                                () => _thisVisit.genRH = double.tryParse(val))),
                      ),
                      Expanded(flex: 1, child: Text('hrs', style: textStyle))
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                            //Last PPM
                            initialValue: _thisVisit.lastPPM!= null 
                                ? _thisVisit.lastPPM.toString() : '',
                            decoration:
                                InputDecoration(labelText: 'Last PPM (RH)'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return fillErrorMessage;
                              }
                              if (double.tryParse(value) == null) {
                                return numErrorMessage;
                              }
                              return null;
                            },
                            onSaved: (val) => setState(() =>
                                _thisVisit.lastPPM = double.tryParse(val))),
                      ),
                      Expanded(flex: 1, child: Text('hrs', style: textStyle))
                    ],
                  ),

                  //DG PPM due
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text('DG due for PPM', style: textStyle),
                  ),
                  Container(
                    decoration: !dgPPMRadBtnValid ? myBoxDecoration() : null,
                    child: Row(
                      key: Key('dgDuePPM'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: dgPPMRadBtn,
                          onChanged: _handleRadioValueChange1,
                        ),
                        Text(
                          'Yes',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: 1,
                          groupValue: dgPPMRadBtn,
                          onChanged: _handleRadioValueChange1,
                        ),
                        Text(
                          'No',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(

                      // mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                              //Frequency
                              initialValue: _thisVisit.freq!= null 
                                ? _thisVisit.freq.toString() : '',
                              decoration:
                                  InputDecoration(labelText: 'Frequency'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return fillErrorMessage;
                                }
                                if (double.tryParse(value) == null) {
                                  return numErrorMessage;
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              onSaved: (val) => setState(() =>
                                  _thisVisit.freq = double.tryParse(val))),
                        ),
                        Expanded(flex: 1, child: Text('Hz', style: textStyle))
                      ]),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            flex: 2,
                            child: TextFormField(
                                //DG Volt
                                initialValue: _thisVisit.dgACVolts!= null 
                                  ? _thisVisit.dgACVolts.toString() : '',
                                decoration:
                                    InputDecoration(labelText: 'DG AC Voltage'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return fillErrorMessage;
                                  }
                                  if (double.tryParse(value) == null) {
                                    return numErrorMessage;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                onSaved: (val) => setState(() => _thisVisit
                                    .dgACVolts = double.tryParse(val)))),
                        Expanded(
                            flex: 1,
                            child: Container(
                                child: Text(
                              'Volts',
                              style: textStyle,
                            )))
                      ]),

                  //PHCN Functional
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text('PHCN Functional', style: textStyle),
                  ),
                  Container(
                    decoration: !phcnRadBtnValid ? myBoxDecoration() : null,
                    child: Row(
                      key: Key('phcnOk'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: phcnRadBtn,
                          onChanged: _handleRadioValueChange4,
                        ),
                        Text(
                          'Yes',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: 1,
                          groupValue: phcnRadBtn,
                          onChanged: _handleRadioValueChange4,
                        ),
                        Text(
                          'No',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text('Hybrid Functional', style: textStyle),
                  ),
                  Container(
                    decoration: !hybridRadBtnValid ? myBoxDecoration() : null,
                    child: Row(
                      key: Key('hybridOk'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: hybridRadBtn,
                          onChanged: _handleRadioValueChange5,
                        ),
                        Text(
                          'Yes',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: 1,
                          groupValue: hybridRadBtn,
                          onChanged: _handleRadioValueChange5,
                        ),
                        Text(
                          'No',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                              //DG Amps
                              initialValue: _thisVisit.dgACLoad!= null 
                                ? _thisVisit.dgACLoad.toString() : '',
                              decoration:
                                  InputDecoration(labelText: 'DG AC Load'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return fillErrorMessage;
                                }
                                if (double.tryParse(value) == null) {
                                  return numErrorMessage;
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              onSaved: (val) => setState(() =>
                                  _thisVisit.dgACLoad = double.tryParse(val)))),
                      Expanded(flex: 1, child: Text('Amps', style: textStyle))
                    ],
                  ),

                  //Radiator Status
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text('Radiator Status', style: textStyle),
                  ),
                  Container(
                    decoration: !radiatorRadBtnValid ? myBoxDecoration() : null,
                    child: Row(
                      key: Key('radOk'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: radiatorRadBtn,
                          onChanged: _handleRadioValueChange3,
                        ),
                        Text(
                          'Ok',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: 1,
                          groupValue: radiatorRadBtn,
                          onChanged: _handleRadioValueChange3,
                        ),
                        Text(
                          'Not Ok',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Engine Oil Level
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text('Engine Oil Level', style: textStyle),
                  ),
                  Container(
                    decoration: !engOilRadBtnValid ? myBoxDecoration() : null,
                    child: Row(
                      key: Key('engOilOk'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: engOilRadBtn,
                          onChanged: _handleRadioValueChange2,
                        ),
                        Text(
                          'Ok',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: 1,
                          groupValue: engOilRadBtn,
                          onChanged: _handleRadioValueChange2,
                        ),
                        Text(
                          'Not Ok',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Diesel dip
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text('Diesel level (Tank Dip)', style: textStyle),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                              initialValue: _thisVisit.dieselDipcm!= null 
                                ? _thisVisit.dieselDipcm.toString() : '',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return fillErrorMessage;
                                }
                                if (double.tryParse(value) == null) {
                                  return numErrorMessage;
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number, //dipcm
                              onSaved: (val) => setState(() => _thisVisit
                                  .dieselDipcm = double.tryParse(val)))),
                      Text('cm', style: textStyle),
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                              //diplts
                              initialValue: _thisVisit.dieselDipLts!= null 
                                ? _thisVisit.dieselDipLts.toString() : '',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return fillErrorMessage;
                                }
                                if (double.tryParse(value) == null) {
                                  return numErrorMessage;
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              onSaved: (val) => setState(() => _thisVisit
                                  .dieselDipLts = double.tryParse(val)))),
                      Text('litres', style: textStyle)
                    ],
                  ),

                  Row(children: [
                    Expanded(
                        flex: 2,
                        child: TextFormField(
                            //Gal Diesel
                            initialValue: _thisVisit.dieselGal!= null 
                                ? _thisVisit.dieselGal.toString() : '',
                            decoration: InputDecoration(
                                labelText: 'Galooli Diesel Level'),
                            validator: (value) {
                              if (value.isNotEmpty &&
                                  double.tryParse(value) == null) {
                                return numErrorMessage;
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onSaved: (val) => setState(() =>
                                _thisVisit.dieselGal = double.tryParse(val)))),
                    Expanded(flex: 1, child: Text('litres', style: textStyle))
                  ]),

                  Row(children: [
                    Expanded(
                        flex: 2,
                        child: TextFormField(
                            //DC load
                            initialValue: _thisVisit.dcLoad!= null 
                                ? _thisVisit.dcLoad.toString() : '',
                            decoration:
                                InputDecoration(labelText: 'DC/Rectifier Load'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return fillErrorMessage;
                              }
                              if (double.tryParse(value) == null) {
                                return numErrorMessage;
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onSaved: (val) => setState(() =>
                                _thisVisit.dcLoad = double.tryParse(val)))),
                    Expanded(flex: 1, child: Text('A', style: textStyle))
                  ]),
                  TextFormField(
                      //No of working modules
                      initialValue: _thisVisit.moduleNo!= null 
                                ? _thisVisit.moduleNo.toString() : '',
                      decoration:
                          InputDecoration(labelText: 'No of working modules'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return fillErrorMessage;
                        }
                        if (double.tryParse(value) == null) {
                          return numErrorMessage;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      onSaved: (val) => setState(
                          () => _thisVisit.moduleNo = double.tryParse(val))),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text('Security light status', style: textStyle),
                  ),
                  Container(
                    decoration: !secLtRadBtnValid ? myBoxDecoration() : null,
                    child: Row(
                      key: Key('secLtOk'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: secLtRadBtn,
                          onChanged: _handleRadioValueChange6,
                        ),
                        Text(
                          'NA',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: 1,
                          groupValue: secLtRadBtn,
                          onChanged: _handleRadioValueChange6,
                        ),
                        Text(
                          'Ok',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: 2,
                          groupValue: secLtRadBtn,
                          onChanged: _handleRadioValueChange6,
                        ),
                        Text(
                          'Not Ok',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text('Aviation light status', style: textStyle),
                  ),
                  Container(
                    decoration: !aviLtRadBtnValid ? myBoxDecoration() : null,
                    child: Row(
                      key: Key('avLtOk'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: aviLtRadBtn,
                          onChanged: _handleRadioValueChange7,
                        ),
                        Text(
                          'NA',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: 1,
                          groupValue: aviLtRadBtn,
                          onChanged: _handleRadioValueChange7,
                        ),
                        Text(
                          'Ok',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: 2,
                          groupValue: aviLtRadBtn,
                          onChanged: _handleRadioValueChange7,
                        ),
                        Text(
                          'Not Ok',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text('Site Janitorial status', style: textStyle),
                  ),
                  Container(
                    decoration: !janitoRadBtnValid ? myBoxDecoration() : null,
                    child: Row(
                      key: Key('janitOk'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: janitoRadBtn,
                          onChanged: _handleRadioValueChange8,
                        ),
                        Text(
                          'Ok',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: 1,
                          groupValue: janitoRadBtn,
                          onChanged: _handleRadioValueChange8,
                        ),
                        Text(
                          'Not Ok',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),

                  TextFormField(
                      //Comments
                      initialValue: _thisVisit.comment,
                      decoration: InputDecoration(labelText: 'Comments'),
                      maxLines: null,
                      onSaved: (val) =>
                          setState(() => _thisVisit.comment = val)),

                  RaisedButton(
                    onPressed: ()=>_validateInputsSave(context),

                    //_validateInputs,
                    child: new Text(
                      'Save Visit',
                      style: new TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                    color: Theme.of(context).accentColor,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  ),
                ])));
  }

    @override
  Widget build(BuildContext context) {
    _thisVisit.dateofVisit = DateTime.now();
    return 
      Scaffold(
        
        appBar: AppBar(title: Text('Visit')),
        body: Builder(
            builder:(context )=> setUp(context)));}
  saveToVisit() {}

  void _handleRadioValueChange1(int val) {
    setState(() {
      dgPPMRadBtn = val;
      _thisVisit.dgDuePPM = (val == 0);
      dgPPMRadBtnValid = true;
    });
  }

  void _handleRadioValueChange2(int val) {
    setState(() {
      engOilRadBtn = val;
      _thisVisit.engOilOk = (val == 0);
      engOilRadBtnValid = true;
    });
  }

  void _handleRadioValueChange3(int val) {
    setState(() {
      radiatorRadBtn = val;
      _thisVisit.radOk = (val == 0);
      radiatorRadBtnValid = true;
    });
  }

  void _handleRadioValueChange4(int val) {
    setState(() {
      phcnRadBtn = val;
      _thisVisit.phcnOk = (val == 0);
      phcnRadBtnValid = true;
    });
  }

  void _handleRadioValueChange5(int val) {
    setState(() {
      hybridRadBtn = val;
      _thisVisit.hybridOk = (val == 0);
      hybridRadBtnValid = true;
    });
  }

  void _handleRadioValueChange6(int val) {
    setState(() {
      secLtRadBtn = val;
      _thisVisit.secLtOk = val;
      secLtRadBtnValid = true;
    });
  }

  void _handleRadioValueChange7(int val) {
    setState(() {
      aviLtRadBtn = val;
      _thisVisit.avLtOk = val;
      aviLtRadBtnValid = true;
      
    });
  }

  void _handleRadioValueChange8(int val) {
    setState(() {
      janitoRadBtn = val;
      _thisVisit.janitOk = (val == 0);
      janitoRadBtnValid = true;
    });
  }

  final snackBar = SnackBar(content: Text('Please check values are complete'));

  // Find the Scaffold in the widget tree and use
  // it to show a SnackBar.

  void _validateInputsSave(context) {
    final form = _formKey.currentState;
    if (!form.validate()) {
      // Text forms has validated.
      // Let's validate radios and checkbox
      //Basically the function compares the Indexes and if less than
      //0, puts a red border
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      var howmanyInvalid = 0;

      setState(() {
        bool checkValue(int index) {

          if (index < 0) {
            howmanyInvalid++;
            return false;
          } else {
            return true;
          }
        }

        dgPPMRadBtnValid = checkValue(dgPPMRadBtn);
        engOilRadBtnValid = checkValue(engOilRadBtn);
        radiatorRadBtnValid = checkValue(radiatorRadBtn);
        phcnRadBtnValid = checkValue(phcnRadBtn);
        hybridRadBtnValid = checkValue(hybridRadBtn);
        janitoRadBtnValid = checkValue(janitoRadBtn);
        secLtRadBtnValid = checkValue(secLtRadBtn);
        aviLtRadBtnValid = checkValue(aviLtRadBtn);
      });

      if (howmanyInvalid > 0) {
        // If some are invalid
        Scaffold.of(context).showSnackBar(snackBar);
      } else{
      _formKey.currentState.save();
      _thisVisit.pending = true;
      Navigator.pop(context, _thisVisit);
      }
    }
  }
}

int booltoInt(bool val) {
  if (val != null) {
    return val ? 0 : 1;
  } else {
    return -1;
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
      width: 3.0,
      color: Colors.red,
    ),
    borderRadius: BorderRadius.all(
        Radius.circular(5.0) //                 <--- border radius here
        ),
  );
}