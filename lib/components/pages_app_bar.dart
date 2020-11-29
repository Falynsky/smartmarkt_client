import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/home_route/route_bloc.dart';
import 'package:smartmarktclient/bloc/home_route/route_event.dart';

class PagesAppBar extends StatefulWidget {
  final String title;

  PagesAppBar({@required this.title});

  @override
  _PagesAppBarState createState() => _PagesAppBarState();
}

class _PagesAppBarState extends State<PagesAppBar> {
  RouteBloc _routeBloc;
  String _title;

  @override
  void initState() {
    super.initState();
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    _title = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => _backToMainPage(),
            ),
            SizedBox(width: 20),
            Text(_title),
          ],
        ),
      ),
      elevation: .1,
      backgroundColor: Colors.teal,
    );
  }

  void _backToMainPage() {
    final LoadMainMenuEvent loadMainMenuEvent = LoadMainMenuEvent();
    _routeBloc.add(LoadMainMenuEvent());
  }
}
