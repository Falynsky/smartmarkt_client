import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';

class ScannerPageButton extends StatefulWidget {
  ScannerPageButton();

  @override
  _ScannerPageButtonState createState() => _ScannerPageButtonState();
}

class _ScannerPageButtonState extends State<ScannerPageButton> {
  RouteBloc _routeBloc;

  @override
  void initState() {
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xAF24756f),
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          child: new InkWell(
            onTap: () => setState(() {
              _routeBloc.add(ScannerEvent());
            }),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  _icon(Icons.scanner),
                  SizedBox(height: 20.0),
                  _label("Scanner")
                ],
              ),
            ),
          ),
        ));
  }

  Center _icon(IconData icon) {
    return Center(
      child: Icon(
        icon,
        size: 40.0,
        color: Colors.black,
      ),
    );
  }

  Center _label(String title) {
    return new Center(
      child: new Text(
        title,
        style: new TextStyle(fontSize: 18.0, color: Colors.black),
      ),
    );
  }
}
