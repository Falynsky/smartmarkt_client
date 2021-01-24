import 'package:flutter/material.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class HistoryDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialogs Magic'),
        backgroundColor: analogThree,
      ),
      body: buildDetailsPage(),
      backgroundColor: analogFour,
    );
  }

  Text buildDetailsPage() {
    return Text("It's a Dssssialog!");
  }
}
