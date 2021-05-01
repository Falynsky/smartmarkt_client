import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/utilities/colors.dart';
import 'package:smartmarktclient/utilities/gradient.dart';

class ConfiguratorPage extends StatefulWidget {
  @override
  _ConfiguratorPageState createState() => _ConfiguratorPageState();
}

class _ConfiguratorPageState extends State<ConfiguratorPage> {
 late RouteBloc _routeBloc;
 late ConfigureBloc _configureBloc;

  @override
  void initState() {
    super.initState();
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    _configureBloc = ConfigureBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => _configureBloc,
        child: BlocListener<ConfigureBloc, ConfigureState>(
            listener: (context, state) {
              if (state is LoadConfigureMenuState) {
              } else if (state is ShopAvailableState) {
                _routeBloc.add(LoadLoginPageEvent());
              } else if (state is ShopUnAvailableState) {
                final snackBar = SnackBar(
                  content: Text("Nie znaleziono sklepu"),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: complementaryThree,
                  action: SnackBarAction(
                    label: "OK",
                    onPressed: () => {},
                    textColor: Colors.black54,
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              setState(() {});
            },
            child: _configPage(context)),
      ),
    );
  }

  Widget _configPage(BuildContext context) {
    return Stack(
      children: <Widget>[
        gradientBackground(),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buttonDescription(),
              SizedBox(height: 25),
              _scannerButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buttonDescription() {
    return Text(
      "Aby rozpocząć zakupy\nzeskanuj kod sklepu",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
    );
  }

  Widget _scannerButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(25.0),
      splashFactory: InkRipple.splashFactory,
      child: Container(
        decoration: BoxDecoration(
          color: secondaryColor,
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.qr_code_scanner_rounded,
          size: 150,
        ),
      ),
      onTap: () => _configureBloc.add(ScanShopCodeEvent()),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _configureBloc.close();
  }
}
