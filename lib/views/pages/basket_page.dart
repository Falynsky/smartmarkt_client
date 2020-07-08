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

  @override
  void initState() {
    _httpService = HttpService();
    test();
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
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _routeBloc.add(MainMenuEvent());
                  });
                },
              ),
              SizedBox(width: 20),
              Text("Basket"),
            ],
          ),
        ),
        elevation: .1,
        backgroundColor: Colors.black45,
      ),
      body: Container(
        color: Colors.amber,
      ),
    );
  }

  void test() async {
    String basketUrl = "/baskets_products/getUserProducts";
    final response = await _httpService.get(url: basketUrl);

    if (response['success'] == true) {
      List list = response['data'];
      list.forEach((element) {
        print(element['name'] +
            " : " +
            element['quantity'].toString() +
            " " +
            element['quantityType']);
      });
      print("Retrieved data products");
    } else {
      print("Error while retrieving basket products");
    }
  }
}
