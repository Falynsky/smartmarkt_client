import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/http/http_service.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class ScanResultComponent extends StatefulWidget {
  ScanResultComponent();

  @override
  State<StatefulWidget> createState() => ScanResultComponentState();
}

class ScanResultComponentState extends State<ScanResultComponent> {
  Map<String, dynamic> _scannedInfo;
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
          _scannedInfo = state.productData;
        } else if (state is ErrorScanState) {
          _scannedInfo = null;
          _hasError = true;
        }
        setState(() {});
      },
      child: Column(
        children: [
          if (_hasError != null && _hasError) _productNotFoundScreen(),
          if (_scannedInfo != null) productFoundScreen(context),
        ],
      ),
    );
  }

  Widget _productNotFoundScreen() {
    return Container(
      margin: EdgeInsets.only(top: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 90,
            color: complementaryThree,
          ),
          Text(
            "Nie znaleziono \nproduktu",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: complementaryThree,
            ),
          ),
        ],
      ),
    );
  }

  Widget productFoundScreen(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                child: Image.network(
                  '${HttpService.hostUrl}/files/download/${_scannedInfo['documentName']}.${_scannedInfo['documentType']}/db',
                  headers: HttpService.headers,
                  errorBuilder: (_, __, ___) {
                    return Icon(Icons.image_not_supported, size: 300);
                  },
                ),
              ),
            ),
          ),
          Divider(thickness: 1.5),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _productName(),
                      SizedBox(height: 15),
                      _productInfoRow(
                          "Kategoria:", _scannedInfo['productType']),
                      SizedBox(height: 5),
                      _scannedInfo['afterDiscount'] == null
                          ? _productInfoRow(
                              "Cena:", "${_scannedInfo['price']}zł")
                          : _productInfoRow(
                              "Cena:", "${_scannedInfo['price']}zł",
                              newValue: "${_scannedInfo['afterDiscount']}zł"),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                _addProductToBasketButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _productName() {
    return Text(
      _scannedInfo['name'],
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
    );
  }

  Widget _productInfoRow(String label, String value, {String newValue}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            decoration: newValue != null ? TextDecoration.lineThrough : null,
            decorationColor: newValue != null ? Colors.red : null,
            decorationThickness: newValue != null ? 2 : null,
          ),
        ),
        if (newValue != null)
          Text(
            newValue,
            style: TextStyle(fontSize: 15),
          ),
      ],
    );
  }

  Widget _addProductToBasketButton(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: secondaryColor,
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
              AddProductToBasketEvent(productId: _scannedInfo['id']);
          return _scannerBloc.add(addProductToBasketEvent);
        },
      ),
    );
  }
}
