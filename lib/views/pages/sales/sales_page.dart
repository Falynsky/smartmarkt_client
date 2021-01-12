import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';
import 'package:smartmarktclient/utilities/circular_idicator.dart';

class SalesPage extends StatefulWidget {
  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  RouteBloc _routeBloc;
  SalesBloc _salesBloc;
  bool _isLoaded;
  List<Map<String, dynamic>> _sales;

  @override
  void initState() {
    super.initState();
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    _salesBloc = SalesBloc();

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
          create: (_) => _salesBloc..add(SalesLoadingEvent()),
          child: BlocListener<SalesBloc, SalesState>(
            listener: (context, state) {
              if (state is SalesLoadingState) {
                _isLoaded = false;
              } else if (state is LoadedSalesState) {
                _isLoaded = true;
                _sales = state.sales;
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
      return CircularIndicator();
    }
    return Container(
      color: Color(0xFF40c5ba),
      child: ListView.builder(
        itemCount: _sales != null ? _sales.length : 0,
        itemBuilder: (context, index) {
          return _salesTypeCard(index);
        },
      ),
    );
  }

  Widget _salesTypeCard(int index) {
    return Container(
      child: InkWell(
        onTap: () {},
        child: Card(
          color: Color(0xFFDDDDDD),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${_sales[index]['title']}"),
                Text("${_sales[index]['description']}"),
              ],
            ),
            padding: EdgeInsets.all(20),
          ),
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
