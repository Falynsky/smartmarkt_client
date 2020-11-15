import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/http/http_service.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  RouteBloc _routeBloc;
  HttpService _httpService;
  List<dynamic> basketProducts;

  @override
  void initState() {
    _httpService = HttpService();
    _getBasketProducts();
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: <Widget>[
              _arrowBackButton(),
              SizedBox(width: 20),
              Text("Koszyk"),
            ],
          ),
        ),
        elevation: .1,
        backgroundColor: Colors.black45,
      ),
      body: productList(),
      floatingActionButton: _buyFabButton(),
    );
  }

  IconButton _arrowBackButton() {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        _routeBloc.add(LoadMainMenuEvent());
      },
    );
  }

  Widget productList() {
    return basketProducts == null
        ? Container()
        : basketProducts.isEmpty
            ? _emptyBasketInfo()
            : _basketProductsList();
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

  ListView _basketProductsList() {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 70),
      itemCount: basketProducts != null ? basketProducts.length : 0,
      itemBuilder: (context, index) {
        return listCard(index);
      },
    );
  }

  Widget listCard(int index) {
    return Card(
      child: InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            children: <Widget>[
              Icon(Icons.image),
              Spacer(),
              Text(basketProducts[index]['name']),
              Spacer(),
              Text('ilość: ' + basketProducts[index]['quantity'].toString()),
              SizedBox(width: 10),
              InkWell(
                child: Icon(Icons.close),
                onTap: () {
                  removeObject(index);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> removeObject(int index) async {
    Map<String, dynamic> body = {
      "productId": basketProducts[index]['productId'],
    };
    String removeUrl = "/baskets_products/remove";
    final response = await _httpService.post(url: removeUrl, body: body);
    if (response['success'] == true) {
      setState(() {
        basketProducts.removeAt(index);
      });
    }
  }

  FloatingActionButton _buyFabButton() {
    return FloatingActionButton.extended(
      onPressed: () {},
      label: Text("BUY"),
      icon: Icon(Icons.shopping_cart),
      backgroundColor: Colors.greenAccent,
    );
  }

  void _getBasketProducts() async {
    String basketUrl = "/baskets_products/getUserProducts";
    final response = await _httpService.get(url: basketUrl);
    if (response['success'] == true) {
      setState(() {
        basketProducts = response['data']['data'];
      });
    }
  }
}
