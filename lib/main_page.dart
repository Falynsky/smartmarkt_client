import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  RouteBloc _routeBloc;

  @override
  void initState() {
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("DASHBOARD"),
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
            makeDashboardItem("Items", Icons.fastfood),
          ],
        ),
      ),
    );
  }

  Card makeDashboardItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: onTap,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  _icon(icon),
                  SizedBox(height: 20.0),
                  _label(title)
                ],
              ),
            ),
          ),
        ));
  }

  void onTap() {
    setState(() {
      _routeBloc.add(ItemsEvent());
    });
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
