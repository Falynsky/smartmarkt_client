import 'package:flutter/material.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: PagesAppBar(title: "Ustawienia"),
      ),
      body: Container(
        color: Colors.lightGreen,
      ),
    );
  }
}
