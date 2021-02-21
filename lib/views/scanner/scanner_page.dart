import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/bloc/scanner/scanner_bloc.dart';
import 'package:smartmarktclient/bloc/scanner/scanner_state.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';
import 'package:smartmarktclient/utilities/colors.dart';
import 'package:smartmarktclient/views/scanner/scanner_page_scan_button.dart';
import 'package:smartmarktclient/views/scanner/scanner_result/scan_component.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  ScannerBloc _scannerBloc;
  RouteBloc _routeBloc;

  @override
  void initState() {
    super.initState();
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    _scannerBloc = ScannerBloc();
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
          child: PagesAppBar(title: "Skaner"),
        ),
        body: BlocProvider(
          create: (_) => _scannerBloc,
          child: BlocListener<ScannerBloc, ScannerState>(
            listener: (context, state) {
              if (state is AddToBasketState) {
                final snackBar = SnackBar(
                  content: Text(state.message),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: complementaryThree,
                  action: SnackBarAction(
                    label: "OK",
                    onPressed: () => {},
                    textColor: Colors.black54,
                  ),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
              setState(() {});
            },
            child: _scannerPage(context),
          ),
        ),
      ),
    );
  }

  Widget _scannerPage(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            _scanButtonLabel(),
            SizedBox(height: 10),
            _scanProductButton(),
            SizedBox(height: 30),
            Divider(thickness: 1.5),
            ScanComponent()
          ],
        ),
      ),
    );
  }

  Widget _scanButtonLabel() {
    return Text(
      "Wciśnij aby \nzeskanować produkt",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      textAlign: TextAlign.center,
    );
  }

  Widget _scanProductButton() {
    return ScannerPageScanButton();
  }

  @override
  void dispose() {
    _scannerBloc.close();
    super.dispose();
  }
}
