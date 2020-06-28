import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';

class SalesPageButton extends StatefulWidget {
  SalesPageButton();

  @override
  _SalesPageButtonState createState() => _SalesPageButtonState();
}

class _SalesPageButtonState extends State<SalesPageButton> {
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
              _routeBloc.add(SalesEvent());
            }),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  _icon(Icons.alarm),
                  SizedBox(height: 20.0),
                  _label("Sales")
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
