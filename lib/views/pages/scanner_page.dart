import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  RouteBloc _routeBloc;

  @override
  void initState() {
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _routeBloc.add(MainMenuEvent());
                  });
                },
              ),
              SizedBox(width: 20),
              Text("Scanner"),
            ],
          ),
        ),
        elevation: .1,
        backgroundColor: Colors.black45,
      ),
      body: Container(
        color: Colors.deepPurple,
        child: Center(
          child: InkWell(
            child: Icon(
              Icons.camera,
              size: 90,
            ),
            onTap: () async {
              var result = await BarcodeScanner.scan();

              print(result.type); // The result type
              // (barcode, cancelled, failed)
              print(result.rawContent); // The barcode content
              print(result.format); // The barcode format (as enum)
              print(result.formatNote);
            },
          ),
        ),
      ),
    );
  }

/*  setState(() {
  RouteBloc routeBloc = BlocProvider.of<RouteBloc>(context);
  routeBloc.add(MainMenuEvent());
  });*/
}
