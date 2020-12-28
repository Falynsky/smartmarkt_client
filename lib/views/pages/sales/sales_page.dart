import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';

class SalesPage extends StatefulWidget {
  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  RouteBloc _routeBloc;
  SalesBloc _salesBloc;
  bool _isLoaded;

  @override
  void initState() {
    super.initState();
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    _salesBloc = SalesBloc();
    _salesBloc.add(SalesLoadingEvent());
    _isLoaded = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _routeBloc.add(LoadMainMenuEvent());
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: PagesAppBar(title: "Promocje"),
        ),
        body: BlocProvider(
          create: (_) => _salesBloc,
          child: BlocListener<SalesBloc, SalesState>(
            listener: (context, state) {
              if (state is SalesLoadingState) {
                _isLoaded = false;
              } else if (state is LoadedSalesState) {
                _isLoaded = true;
              }
              setState(() {});
            },
            child: _salesPage(context),
          ),
        ),
      ),
    );
  }

  Widget _salesPage(BuildContext context) {
    if (!_isLoaded) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                backgroundColor: Colors.teal,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ],
          ),
        ),
      );
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Text(
              "Tu będą promocje",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _salesBloc.close();
  }
}
