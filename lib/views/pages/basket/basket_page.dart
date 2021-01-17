import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';
import 'package:smartmarktclient/http/http_service.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  HttpService _httpService;
  List<dynamic> basketProducts;
  double basketSummary;
  RouteBloc _routeBloc;

  @override
  void initState() {
    _httpService = HttpService();
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    _getBasketProducts();
    _getBasketSummary();
    super.initState();
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
        body: productList(),
        floatingActionButton: _generateCodeFAB(),
      ),
    );
  }

  Widget productList() {
    if (basketProducts == null) {
      return Container();
    }

    if (basketProducts.isEmpty) {
      return _emptyBasketInfo();
    }

    return Column(
      children: [
        _summary(),
        Divider(thickness: 2),
        _basketProductsList(),
      ],
    );
  }

  Widget _summary() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Wartość koszyka: ${basketSummary}zł",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          SizedBox(width: 20),
          InkWell(
            borderRadius: BorderRadius.circular(25.0),
            splashFactory: InkRipple.splashFactory,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.remove_shopping_cart_rounded),
            ),
            onTap: () => _removeBasketProducts(),
          )
        ],
      ),
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

  Widget _basketProductsList() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 70),
        itemCount: basketProducts != null ? basketProducts.length : 0,
        itemBuilder: (context, index) {
          return listCard(index);
        },
      ),
    );
  }

  Widget listCard(int index) {
    Map<String, dynamic> basketProduct = basketProducts[index];
    int quantity = basketProduct['quantity'];
    double price = basketProduct['price'];
    String documentUrl =
        '${HttpService.hostUrl}/files/download/${basketProduct['documentName']}.${basketProduct['documentType']}/db';
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
                  basketProduct['name'],
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                Text('$quantity x ${price}zł'),
                Text('${quantity * price}zł'),
              ],
            ),
            Spacer(),
            InkWell(
              child: Icon(Icons.close),
              onTap: () {
                removeObject(index);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> removeObject(int index) async {
    Map<String, dynamic> body = {
      "productId": basketProducts[index]['productId'],
    };
    String removeUrl = "/baskets_products/remove";
    final response = await _httpService.post(url: removeUrl, postBody: body);
    if (response['success'] == true) {
      setState(() {
        _getBasketProducts();
        _getBasketSummary();
      });
    }
  }

  Widget _generateCodeFAB() {
    if (basketProducts == null || basketProducts.isEmpty) {
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

  void _getBasketProducts() async {
    String basketUrl = "/baskets_products/getUserProducts";
    final response = await _httpService.get(url: basketUrl);
    if (response['success'] == true) {
      setState(() {
        basketProducts = response['data'];
      });
    }
  }

  void _getBasketSummary() async {
    String basketUrl = "/baskets_products/getSummary";
    final response = await _httpService.get(url: basketUrl);
    if (response['success'] == true) {
      setState(() {
        basketSummary = response['data']['summary'];
      });
    }
  }

  void _selectedPositionDialog() {
    if (basketProducts.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            backgroundColor: shadesTwo,
            title: Text(
              "Zeskanuj kod w kasie samoobsługowej",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
            content: Container(
              padding: EdgeInsets.all(5),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BarcodeWidget(
                    barcode: Barcode.upcA(),
                    data: "21234561189",
                    width: 300,
                    height: 200,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              _clearBasketButton(context),
              _hideBarsCodeButton(context)
              // usually buttons at the bottom of the dialog
            ],
          );
        },
      );
    }
  }

  FlatButton _clearBasketButton(BuildContext context) {
    return FlatButton(
      child: Text("Wyczyść koszyk"),
      color: Colors.white,
      textColor: Colors.black,
      onPressed: () {
        _removeBasketProducts();
        Navigator.of(context).pop();
      },
    );
  }

  FlatButton _hideBarsCodeButton(BuildContext context) {
    return FlatButton(
      child: Text("Zamknij"),
      color: Colors.white,
      textColor: Colors.black,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  void _removeBasketProducts() async {
    String basketUrl = "/baskets_products/removeAll";
    final response = await _httpService.post(url: basketUrl);
    if (response['success'] == true) {
      setState(() {
        _getBasketProducts();
        _getBasketSummary();
      });
    }
  }
}
