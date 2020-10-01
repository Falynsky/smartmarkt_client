import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';

class DashboardCard extends StatefulWidget {
  final String label;
  final String pageIdn;
  final IconData iconData;

  DashboardCard({
    this.label,
    this.iconData,
    this.pageIdn,
  });

  @override
  _DashboardCardState createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  RouteBloc _routeBloc;
  String _label;
  String _pageIdn;
  IconData _iconData;

  @override
  void initState() {
    super.initState();
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    _label = widget.label;
    _iconData = widget.iconData;
    _pageIdn = widget.pageIdn;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xAF24756f),
        elevation: 1.0,
        margin: EdgeInsets.all(8.0),
        child: Container(
          child: InkWell(
            onTap: () {
              return _emitLoadPageEvent();
            },
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  _icon(),
                  SizedBox(height: 20.0),
                  _dashboardLabel()
                ],
              ),
            ),
          ),
        ));
  }

  void _emitLoadPageEvent() {
    final loadPageEvent = LoadDashboardPageEvent(pageIdn: _pageIdn);
    return _routeBloc.add(loadPageEvent);
  }

  Center _icon() {
    return Center(
      child: Icon(
        _iconData,
        size: 40.0,
        color: Colors.black,
      ),
    );
  }

  Widget _dashboardLabel() {
    return Center(
      child: Text(
        _label,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
        ),
      ),
    );
  }
}
