import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';
import 'package:smartmarktclient/models/basket_product.dart';
import 'package:smartmarktclient/utilities/circular_idicator.dart';
import 'package:smartmarktclient/utilities/colors.dart';
import 'package:smartmarktclient/views/basket/basket_header.dart';
import 'package:smartmarktclient/views/basket/basket_position.dart';
import 'package:smartmarktclient/views/basket/empty_basket_page.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  RouteBloc _routeBloc;
  BasketBloc _basketBloc;
  bool _isLoaded;

  List<BasketProduct> get basketProducts => _basketBloc.basketProducts;

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

    if (basketProducts == null || basketProducts.isEmpty) {
      return EmptyBasketPage();
    }

    return Column(
      children: [
        BasketHeader(),
        Divider(thickness: 2),
        _basketPositions(),
      ],
    );
  }

  Widget _basketPositions() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 70),
        itemCount: basketProducts != null ? basketProducts.length : 0,
        itemBuilder: (context, index) {
          return BasketPosition(index: index);
        },
      ),
    );
  }

  Widget _generateCodeFAB() {
    if (basketProducts == null || basketProducts.isEmpty || !_isLoaded) {
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
    if (basketProducts.isNotEmpty) {
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

  Widget _purchasedBasketButton(BuildContext context) {
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

  Widget _hideBarsCodeButton(BuildContext context) {
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
