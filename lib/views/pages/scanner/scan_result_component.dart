import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';

class ScanResultComponent extends StatefulWidget {
  ScanResultComponent();

  @override
  State<StatefulWidget> createState() => ScanResultComponentState();
}

class ScanResultComponentState extends State<ScanResultComponent> {
  Map<String, dynamic> _scannedProductInfo;
  ScannerBloc _scannerBloc;
  bool _hasError;

  @override
  void initState() {
    super.initState();
    _scannerBloc = BlocProvider.of<ScannerBloc>(context);
    _hasError = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScannerBloc, ScannerState>(
      listener: (context, state) {
        if (state is CorrectScanState) {
          _hasError = false;
          _scannedProductInfo = state.productData;
        } else if (state is ErrorScanState) {
          _scannedProductInfo = null;
          _hasError = true;
        }
        setState(() {});
      },
      child: Expanded(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_hasError != null && _hasError) _productNotFoundScreen(),
            if (_scannedProductInfo != null) productFoundScreen(context),
            SizedBox(height: 55),
          ],
        )),
      ),
    );
  }

  Widget _productNotFoundScreen() {
    return Container(
      width: 190,
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 90,
            color: Colors.redAccent,
          ),
          Text(
            "Nie znaleziono produktu w bazie",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget productFoundScreen(BuildContext context) {
    String productPrice = _scannedProductInfo['price'].toString() +
        " " +
        _scannedProductInfo['currency'];
    return Container(
      width: 190,
      child: Column(
        children: [
          _productName(),
          SizedBox(height: 15),
          _productInfoRow("Kategoria:", _scannedProductInfo['productType']),
          SizedBox(height: 5),
          _productInfoRow("Cena:", productPrice),
          SizedBox(height: 45),
          _addProductToBasketButton(context),
        ],
      ),
    );
  }

  Widget _productName() {
    return Text(
      _scannedProductInfo['name'],
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
    );
  }

  Widget _productInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  Widget _addProductToBasketButton(BuildContext context) {
    return Container(
      width: 90,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        border: Border.all(
          color: Colors.black,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Dodaj do koszyka",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6),
            Icon(
              Icons.shopping_cart_rounded,
              size: 35,
            ),
          ],
        ),
        onTap: () {
          final addProductToBasketEvent =
              AddProductToBasketEvent(productId: _scannedProductInfo['id']);
          return _scannerBloc.add(addProductToBasketEvent);
        },
      ),
    );
  }
}
