import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class DashboardCard extends StatefulWidget {
  final String label;
  final String pageIdn;
  final IconData iconData;

  DashboardCard({
    required this.label,
    required this.iconData,
    required this.pageIdn,
  });

  @override
  _DashboardCardState createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
late RouteBloc _routeBloc;
late String _label;
late String _pageIdn;
late IconData _iconData;

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
      color: analogThree,
      elevation: 1.5,
      margin: EdgeInsets.all(6.0),
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
                SizedBox(height: 10),
                _dashboardLabel()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _emitLoadPageEvent() {
    final loadPageEvent = LoadDashboardPageEvent(pageIdn: _pageIdn);
    return _routeBloc.add(loadPageEvent);
  }

  Center _icon() {
    return Center(
      child: Icon(
        _iconData,
        size: _pageIdn == 'scanner' ? 90 : 40,
        color: Colors.black,
      ),
    );
  }

  Widget _dashboardLabel() {
    return Center(
      child: Text(
        _label,
        style: TextStyle(
          fontSize: _pageIdn == 'scanner' ? 25 : 18.0,
          color: Colors.black,
        ),
      ),
    );
  }
}
