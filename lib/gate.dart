import 'package:flutter/material.dart';
import 'package:sitecheck3/screens/authenticate/authenticate.dart';
import 'package:sitecheck3/screens/savedVisitsScreen.dart';
import 'package:provider/provider.dart';

//import 'package:sitecheck3/screens/visit_form.dart';

import 'models/user.dart';

class Gateway extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //User is initialised in
    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return SavedVisit();
    }
  }
}
