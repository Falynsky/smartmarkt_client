import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/http/http_service.dart';
import 'package:smartmarktclient/models/basket_product.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class BasketPosition extends StatefulWidget {
  final int index;

  const BasketPosition({required this.index});

  @override
  _BasketPositionState createState() => _BasketPositionState();
}

class _BasketPositionState extends State<BasketPosition> {
  late BasketBloc _basketBloc;
  late int _index;
  late BasketProduct _basketProduct;
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _basketBloc = BlocProvider.of<BasketBloc>(context);
    _index = widget.index;
    _basketProduct = _basketBloc.basketProducts[_index];
    _quantity = _basketProduct.quantity;
  }

  @override
  void didUpdateWidget(covariant BasketPosition oldWidget) {
    super.didUpdateWidget(oldWidget);
    _index = widget.index;
    _basketProduct = _basketBloc.basketProducts[_index];
    _quantity = _basketProduct.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return listCard();
  }

  Widget listCard() {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _basketProductImage(),
            SizedBox(width: 20),
            _basketProductInfo(),
            Spacer(),
            _changeQuantityButtons(),
            SizedBox(width: 20),
            _removeProductButton()
          ],
        ),
      ),
    );
  }

  Image _basketProductImage() {
    String documentUrl =
        'http://${HttpService.hostUrl}/files/download/${_basketProduct.documentName}.${_basketProduct.documentType}/db';
    return Image.network(
      '$documentUrl/.2',
      headers: HttpService.headers,
      errorBuilder: (_, __, ___) {
        return Icon(Icons.image_not_supported);
      },
    );
  }

  Column _basketProductInfo() {
    double price = _basketProduct.price;
    double discountPrice = _basketProduct.discountPrice;
    double summary = _basketProduct.summary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _basketProduct.name,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        Text('$_quantity x ${price}zł'),
        discountPrice == 0
            ? Text('${summary}zł')
            : Row(
                children: [
                  Text(
                    '${summary}zł',
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.red,
                      decorationThickness: 2,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text('${discountPrice}zł'),
                ],
              ),
      ],
    );
  }

  Widget _changeQuantityButtons() {
    int productId = _basketProduct.productId;
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(25.0),
          splashFactory: InkRipple.splashFactory,
          child: Icon(Icons.arrow_drop_up_rounded, size: 35),
          onTap: () {
            final addOneToBasketEvent =
                AddOneToBasketEvent(productId: productId);
            _basketBloc.add(addOneToBasketEvent);
          },
        ),
        if (_quantity > 1)
          InkWell(
            borderRadius: BorderRadius.circular(25.0),
            splashFactory: InkRipple.splashFactory,
            child: Icon(Icons.arrow_drop_down_rounded, size: 35),
            onTap: () {
              final addOneToBasketEvent =
                  RemoveOneFromBasketEvent(productId: productId);
              _basketBloc.add(addOneToBasketEvent);
            },
          ),
        if (_quantity == 1) SizedBox(height: 35, width: 35)
      ],
    );
  }

  InkWell _removeProductButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(25.0),
      splashFactory: InkRipple.splashFactory,
      child: Icon(Icons.close),
      onTap: () => _showRemoveButtonDialog(
        event: RemoveBasketProductEvent(index: _index),
        info: "Czy na pewno chcesz usunąć produkt z koszyka?",
      ),
    );
  }

  Future<void> _showRemoveButtonDialog({
    required BasketEvent event,
    required String info,
  }) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black54,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(90.0)),
          ),
          child: AlertDialog(
            backgroundColor: shadesThree,
            title: Text("Uwaga!"),
            titleTextStyle: TextStyle(color: complementaryThree, fontSize: 20),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(info),
                ],
              ),
            ),
            contentTextStyle: TextStyle(color: Colors.white70, fontSize: 16),
            actions: <Widget>[
              TextButton(
                child: Text('Nie', style: TextStyle(color: complementaryThree)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Tak', style: TextStyle(color: complementaryThree)),
                onPressed: () {
                  _basketBloc.add(event);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
