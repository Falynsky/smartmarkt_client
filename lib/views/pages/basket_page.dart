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
        floatingActionButton: _buyFabButton(),
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
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 8),
            child: Text(
              "Wartość koszyka: ${basketSummary}zł",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _emptyBasketInfo() {
    return Container(
      child: Center(
        child: Text(
          "No products in basket",
          style: TextStyle(
            color: Colors.greenAccent,
            fontSize: 25,
          ),
        ),
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
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.image, size: 60),
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

  FloatingActionButton _buyFabButton() {
    return FloatingActionButton.extended(
      onPressed: () {},
      label: Text("BUY", style: TextStyle(color: complementaryFour)),
      icon: Icon(
        Icons.shopping_cart,
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
}
