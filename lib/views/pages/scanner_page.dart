import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/scanner/scanner_bloc.dart';
import 'package:smartmarktclient/bloc/scanner/scanner_event.dart';
import 'package:smartmarktclient/bloc/scanner/scanner_state.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';

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
            if (state is CorrectScanState) {
              _showDialog(
                context,
                state.name,
                state.price,
                state.currency,
              );
            } else if (state is ErrorScanState) {
              _showErrorDialog(context);
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
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            _checkPriceButton(context),
          ],
        ),
      ),
    );
  }

  Widget _checkPriceButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 60),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xff7c94b6),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sprawdź cenę produktu"),
            SizedBox(width: 6),
            Icon(Icons.monetization_on_rounded),
          ],
        ),
        onTap: () => _scannerBloc.add(GetProductInfoEvent()),
      ),
    );
  }

  void _showDialog(
    BuildContext context,
    String name,
    String price,
    String currency,
  ) {
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
      },
    );
  }

  void _showErrorDialog(BuildContext context) {
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

  @override
  void dispose() {
    super.dispose();
  }
}
