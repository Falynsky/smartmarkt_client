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

  @override
  void initState() {
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    _salesBloc = SalesBloc();
    super.initState();
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
              if (state is LoadedSalesState) {}
              setState(() {});
            },
            child: _salesPage(context),
          ),
        ),
      ),
    );
  }

  Widget _salesPage(BuildContext context) {
    return Container(color: Colors.black12);
  }

  @override
  void dispose() {
    super.dispose();
    _salesBloc.close();
  }
}
