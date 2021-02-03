import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/views/scanner/scanner_result/scanner_result.dart';

import 'file:///S:/repositories/e_thesis/smartmarkt_client/lib/views/scanner/scanner_result/empty_scanner_result.dart';

class ScanComponent extends StatefulWidget {
  ScanComponent();

  @override
  State<StatefulWidget> createState() => ScanComponentState();
}

class ScanComponentState extends State<ScanComponent> {
  Map<String, dynamic> _scannedInfo;
  bool _hasError;

  @override
  void initState() {
    super.initState();
    _hasError = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScannerBloc, ScannerState>(
      listener: (context, state) {
        if (state is CorrectScanState) {
          _hasError = false;
          _scannedInfo = state.productData;
        } else if (state is ErrorScanState) {
          _scannedInfo = null;
          _hasError = true;
        }
        setState(() {});
      },
      child: Column(
        children: [
          if (_hasError != null && _hasError) EmptyScannerResult(),
          if (_scannedInfo != null) ScannerResult(scannedInfo: _scannedInfo),
        ],
      ),
    );
  }
}
