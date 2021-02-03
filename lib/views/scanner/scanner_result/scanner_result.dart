import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/http/http_service.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class ScannerResult extends StatefulWidget {
  final Map<String, dynamic> scannedInfo;

  ScannerResult({@required this.scannedInfo});

  @override
  _ScannerResultState createState() => _ScannerResultState();
}

class _ScannerResultState extends State<ScannerResult> {
  Map<String, dynamic> _scannedInfo;
  ScannerBloc _scannerBloc;

  @override
  void initState() {
    super.initState();
    _scannerBloc = BlocProvider.of<ScannerBloc>(context);
    _scannedInfo = widget.scannedInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _scannedProductImage(),
          Divider(thickness: 1.5),
          SizedBox(height: 15),
          _bottomScannerData(context),
        ],
      ),
    );
  }

  Container _scannedProductImage() {
    return Container(
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
    );
  }

  Widget _bottomScannerData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                _productName(),
                SizedBox(height: 15),
                _productInfoRow("Kategoria:", _scannedInfo['productType']),
                SizedBox(height: 5),
                _scannerInfoPriceRow(),
              ],
            ),
          ),
          SizedBox(width: 20),
          _addProductToBasketButton(context),
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
        _productInfoLabel(label),
        _productInfoOriginalValue(value, newValue),
        if (newValue != null) _productInfoValue(newValue),
      ],
    );
  }

  Widget _productInfoLabel(String label) {
    return Text(
      label,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
    );
  }

  Widget _productInfoOriginalValue(String value, String newValue) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 15,
        decoration: newValue != null ? TextDecoration.lineThrough : null,
        decorationColor: newValue != null ? Colors.red : null,
        decorationThickness: newValue != null ? 2 : null,
      ),
    );
  }

  Widget _productInfoValue(String newValue) {
    return Text(newValue, style: TextStyle(fontSize: 15));
  }

  Widget _scannerInfoPriceRow() {
    return _scannedInfo['afterDiscount'] == null
        ? _productInfoRow("Cena:", "${_scannedInfo['price']}zł")
        : _productInfoRow("Cena:", "${_scannedInfo['price']}zł",
            newValue: "${_scannedInfo['afterDiscount']}zł");
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
