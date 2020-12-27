import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/scanner/scanner_bloc.dart';
import 'package:smartmarktclient/bloc/scanner/scanner_event.dart';
import 'package:smartmarktclient/bloc/scanner/scanner_state.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';
import 'package:smartmarktclient/views/pages/scanner/scan_result_component.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  ScannerBloc _scannerBloc;

  @override
  void initState() {
    super.initState();
    _scannerBloc = ScannerBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                backgroundColor: Colors.amber,
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
    );
  }

  Center _scannerPage(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            _buttonLabel(),
            SizedBox(height: 10),
            _scanProductButton(context),
            SizedBox(height: 30),
            Container(color: Colors.black12, height: 1.5),
            ScanResultComponent()
          ],
        ),
      ),
    );
  }

  Widget _buttonLabel() {
    return Text(
      "Zeskanuj produkt",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      textAlign: TextAlign.center,
    );
  }

  Widget _scanProductButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        border: Border.all(
          color: Colors.black,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.qr_code,
              size: 85,
            ),
          ],
        ),
        onTap: () => _scannerBloc.add(GetProductInfoEvent()),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
