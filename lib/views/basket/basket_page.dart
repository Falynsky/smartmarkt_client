import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';
import 'package:smartmarktclient/http/http_service.dart';
import 'package:smartmarktclient/models/basket_product.dart';
import 'package:smartmarktclient/utilities/circular_idicator.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  RouteBloc _routeBloc;
  BasketBloc _basketBloc;
  bool _isLoaded;

  @override
  void initState() {
    super.initState();
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    _basketBloc = BasketBloc();
    _isLoaded = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _routeBloc.add(LoadMainMenuEvent());
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: PagesAppBar(title: "Koszyk"),
        ),
        body: BlocProvider(
          create: (_) => _basketBloc..add(LoadingBasketEvent()),
          child: BlocListener<BasketBloc, BasketState>(
            listener: (context, state) {
              if (state is LoadingBasketState) {
                _isLoaded = false;
              } else if (state is LoadedBasketState) {
                _isLoaded = true;
              } else if (state is ShowBasketSnackBarState) {
                final snackBar = SnackBar(
                  content: Text(state.message),
                  backgroundColor: complementaryThree,
                  action: SnackBarAction(
                    label: "OK",
                    onPressed: () => {},
                    textColor: Colors.black54,
                  ),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
              setState(() {});
            },
            child: productList(),
          ),
        ),
        floatingActionButton: _generateCodeFAB(),
      ),
    );
  }

  Widget productList() {
    if (!_isLoaded) {
      return CircularIndicator();
    }

    if (_basketBloc.basketProducts == null ||
        _basketBloc.basketProducts.isEmpty) {
      return _emptyBasketInfo();
    }

    return Column(
      children: [
        _basketSummary(),
        Divider(thickness: 2),
        _basketProductsList(),
      ],
    );
  }

  Widget _emptyBasketInfo() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_basket_outlined,
            size: 100,
            color: complementaryThree,
          ),
          Text(
            "Brak produktów \nw koszyku",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: complementaryThree,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _basketSummary() {
    final summaryAfterDiscount = _basketBloc.summaryAfterDiscount;
    final basketSummary = _basketBloc.basketSummary;
    var basketWithDiscount = summaryAfterDiscount < basketSummary;
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 8, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _summaryTitle(),
              basketWithDiscount ? _regularSummaryCrossed() : _regularSummary(),
              SizedBox(width: 10),
              if (basketWithDiscount) _discountSummary(),
            ],
          ),
          _clearBasketTopButton()
        ],
      ),
    );
  }

  Widget _regularSummary() {
    return Text(
      "${_basketBloc.summaryAfterDiscount}zł ",
      style: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 15,
      ),
    );
  }

  Widget _regularSummaryCrossed() {
    return Text(
      "${_basketBloc.basketSummary}zł ",
      style: TextStyle(
        decoration: TextDecoration.lineThrough,
        decorationColor: Colors.red,
        decorationThickness: 2,
        fontWeight: FontWeight.w800,
        fontSize: 15,
      ),
    );
  }

  Widget _discountSummary() {
    return Text(
      "${_basketBloc.summaryAfterDiscount}zł",
      style: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 15,
      ),
    );
  }

  Widget _clearBasketTopButton() {
    return InkWell(
        borderRadius: BorderRadius.circular(25.0),
        splashFactory: InkRipple.splashFactory,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.remove_shopping_cart_rounded),
        ),
        onTap: () => _showRemoveButtonDialog(
              event: ClearBasketEvent(),
              info: "Czy na pewno chcesz wyczyścić koszyk?",
            ));
  }

  Text _summaryTitle() {
    return Text(
      "Wartość koszyka: ",
      style: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 15,
      ),
    );
  }

  Widget _basketProductsList() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 70),
        itemCount: _basketBloc.basketProducts != null
            ? _basketBloc.basketProducts.length
            : 0,
        itemBuilder: (context, index) {
          return listCard(index);
        },
      ),
    );
  }

  Widget listCard(int index) {
    BasketProduct basketProduct = _basketBloc.basketProducts[index];
    int quantity = basketProduct.quantity;
    double price = basketProduct.price;
    double discountPrice = basketProduct.discountPrice;
    double summary = basketProduct.summary;
    int productId = basketProduct.productId;
    String documentUrl =
        '${HttpService.hostUrl}/files/download/${basketProduct.documentName}.${basketProduct.documentType}/db';
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.network(
              '$documentUrl/.2',
              headers: HttpService.headers,
              errorBuilder: (_, __, ___) {
                return Icon(Icons.image_not_supported);
              },
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  basketProduct.name,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                Text('$quantity x ${price}zł'),
                discountPrice == null
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
            ),
            Spacer(),
            Column(
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
                if (quantity > 1)
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
                if(quantity==1)
                  SizedBox(height: 35, width: 35)
              ],
            ),
            SizedBox(width: 20),
            InkWell(
              borderRadius: BorderRadius.circular(25.0),
              splashFactory: InkRipple.splashFactory,
              child: Icon(Icons.close),
              onTap: () => _showRemoveButtonDialog(
                event: RemoveBasketProductEvent(index: index),
                info: "Czy na pewno chcesz usunąć produkt z koszyka?",
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showRemoveButtonDialog({
    @required BasketEvent event,
    @required String info,
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
              FlatButton(
                child: Text('Nie'),
                textColor: complementaryThree,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Tak'),
                textColor: complementaryThree,
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

  Widget _generateCodeFAB() {
    if (_basketBloc.basketProducts == null ||
        _basketBloc.basketProducts.isEmpty ||
        !_isLoaded) {
      return Container();
    }
    return FloatingActionButton.extended(
      onPressed: () => _selectedPositionDialog(),
      label: Text("Generuj kod", style: TextStyle(color: complementaryFour)),
      icon: Icon(
        Icons.qr_code_rounded,
        color: complementaryFour,
      ),
      backgroundColor: complementaryThree,
    );
  }

  void _selectedPositionDialog() {
    if (_basketBloc.basketProducts.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: shadesThree,
            title: Text("Zeskanuj kod w kasie samoobsługowej"),
            titleTextStyle: TextStyle(color: complementaryThree, fontSize: 20),
            content: Container(
              padding: EdgeInsets.all(5),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BarcodeWidget(
                    barcode: Barcode.code128(),
                    data: _basketBloc.currentUserBasketId,
                    width: 300,
                    height: 200,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                children: [
                  _purchasedBasketButton(context),
                  _hideBarsCodeButton(context),
                ],
              )
              // usually buttons at the bottom of the dialog
            ],
          );
        },
      );
    }
  }

  FlatButton _purchasedBasketButton(BuildContext context) {
    return FlatButton(
      child: Text("Zakupiono \nprodukty", textAlign: TextAlign.center),
      textColor: complementaryThree,
      onPressed: () {
        _emitPurchaseAllBasketProducts();
        Navigator.of(context).pop();
      },
    );
  }

  void _emitPurchaseAllBasketProducts() async {
    _basketBloc.add(PurchaseBasketProductsEvent());
  }

  FlatButton _hideBarsCodeButton(BuildContext context) {
    return FlatButton(
      child: Text("Zamknij"),
      textColor: complementaryThree,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _basketBloc.close();
  }
}
