import 'package:flutter/material.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';

class SalesPage extends StatefulWidget {
  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: PagesAppBar(title: "Promocje"),
      ),
      body: Container(
        color: Colors.green,
      ),
    );
  }
}
