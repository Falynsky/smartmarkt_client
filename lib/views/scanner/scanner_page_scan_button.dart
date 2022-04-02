import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class ScannerPageScanButton extends StatefulWidget {
  @override
  _ScannerPageScanButtonState createState() => _ScannerPageScanButtonState();
}

class _ScannerPageScanButtonState extends State<ScannerPageScanButton> {
  late ScannerBloc _scannerBloc;

  @override
  void initState() {
    super.initState();
    _scannerBloc = BlocProvider.of<ScannerBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
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
            Icon(Icons.qr_code, size: 85),
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
