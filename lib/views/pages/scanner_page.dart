import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/http/http_service.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  RouteBloc _routeBloc;
  HttpService _httpService;

  @override
  void initState() {
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    _httpService = HttpService();
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
                onPressed: () => _routeBloc.add(LoadMainMenuEvent()),
              ),
              SizedBox(width: 20),
              Text("Skaner"),
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
              ScanResult result = await BarcodeScanner.scan();
              int code = int.parse(result.rawContent);

              if (code != null) {
                String barsCode = "/barsCodes/$code";
                final response = await _httpService.get(url: barsCode);
                Map data = response['data'];
                if (response['success'] && data.isNotEmpty) {
                  String name = data['name'].toString();
                  String price = data['price'].toString();
                  String currency = data['currency'].toString();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("$name"),
                          titleTextStyle: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 28,
                          ),
                          content: Row(
                            children: [
                              Text(
                                "Cena: $price $currency",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            FlatButton(
                              child: Text(
                                "OK",
                                style: TextStyle(fontSize: 18),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Błąd!"),
                          titleTextStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 28,
                          ),
                          content: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "Zeskanowny produkt nie jest zarejestrowany w zasobach sklepu.",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            FlatButton(
                              child: Text(
                                "OK",
                                style: TextStyle(fontSize: 18),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
