import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/utilities/circular_idicator.dart';

class ConfiguratorPage extends StatefulWidget {
  @override
  _ConfiguratorPageState createState() => _ConfiguratorPageState();
}

class _ConfiguratorPageState extends State<ConfiguratorPage> {
  RouteBloc _routeBloc;
  ConfigureBloc _configureBloc;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    _configureBloc = ConfigureBloc();
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => _configureBloc,
        child: BlocListener<ConfigureBloc, ConfigureState>(
            listener: (context, state) {
              if (state is LoadConfigureMenuState) {
                _isLoading = true;
              }
              setState(() {});
            },
            child: _loginPage(context)),
      ),
    );
  }

  Widget _loginPage(BuildContext context) {
    if (_isLoading) {
      return CircularIndicator();
    }
    return Container(color: Colors.amberAccent);
  }

  @override
  void dispose() {
    super.dispose();
    _routeBloc.close();
    _configureBloc.close();
  }
}
