import 'package:flutter/material.dart';
import 'package:smartmarktclient/buttons/basket_page_button.dart';
import 'package:smartmarktclient/buttons/items_page_button.dart';
import 'package:smartmarktclient/buttons/profile_page_button.dart';
import 'package:smartmarktclient/buttons/sales_page_button.dart';
import 'package:smartmarktclient/buttons/scanner_page_button.dart';
import 'package:smartmarktclient/buttons/settings_page_button.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Smart Markt"),
        ),
        elevation: .1,
        backgroundColor: Colors.black45,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 2),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(3),
          children: <Widget>[
            ItemsPageButton(),
            ScannerPageButton(),
            SalesPageButton(),
            BasketPageButton(),
            ProfilePageButton(),
            SettingsPageButton(),
          ],
        ),
      ),
    );
  }
}
