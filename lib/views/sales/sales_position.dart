import 'package:flutter/material.dart';
import 'package:smartmarktclient/http/http_service.dart';
import 'package:smartmarktclient/models/sale.dart';
import 'package:smartmarktclient/views/products_panel/products/large_image_dialog.dart';

class SalesPosition extends StatefulWidget {
  final Sale sale;

  SalesPosition({required this.sale});

  @override
  _SalesPositionState createState() => _SalesPositionState();
}

class _SalesPositionState extends State<SalesPosition> {
  late Sale _sale;

  @override
  void initState() {
    super.initState();
    _sale = widget.sale;
  }

  @override
  void didUpdateWidget(covariant SalesPosition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sale != widget.sale) {
      _sale = widget.sale;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.white,
        child: Container(
          child: Row(
            children: [
              _imageButton(),
              SizedBox(width: 10),
              _saleDataColumn(),
            ],
          ),
          padding: EdgeInsets.all(20),
        ),
      ),
    );
  }

  InkWell _imageButton() {
    String documentUrl = 'http://${HttpService.hostUrl}/files/download/${_sale.docName}.${_sale.docType}/db';
    return InkWell(
      child: Image.network(
        '$documentUrl/70/70',
        headers: HttpService.headers,
        errorBuilder: (_, __, ___) {
          return Icon(Icons.image_not_supported);
        },
      ),
      onTap: () => LargeImageDialog().showDialogBox(context, documentUrl),
    );
  }

  Widget _saleDataColumn() {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _saleTitle(),
          _saleDescription(),
          SizedBox(height: 10),
          if (_sale.discount != 0) _salePricesRow(),
        ],
      ),
    );
  }

  Widget _saleTitle() {
    return Text(
      "${_sale.title}",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _saleDescription() {
    return Text(
      "${_sale.description}",
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _salePricesRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Rabat: ${_sale.discount * 100}%"),
        Row(
          children: <Widget>[
            Text("Cena: "),
            Text(
              "${_sale.originalPrice} zł",
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.red,
                decorationThickness: 2,
              ),
            ),
            SizedBox(width: 10),
            Text("${_afterDiscountRounded(_sale)} zł"),
          ],
        ),
      ],
    );
  }

  String _afterDiscountRounded(Sale sale) {
    return (sale.originalPrice * (1 - sale.discount)).toStringAsFixed(2);
  }
}
