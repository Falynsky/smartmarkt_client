import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/home_route/route_event.dart';
import 'package:smartmarktclient/bloc/home_route/route_bloc.dart';
import 'package:smartmarktclient/http/http_service.dart';

class ProductTypesPage extends StatefulWidget {
  @override
  _ProductTypesPageState createState() => _ProductTypesPageState();
}

class _ProductTypesPageState extends State<ProductTypesPage> {
  List<dynamic> productTypes;

  RouteBloc _routeBloc;
  HttpService _httpService;
  final String url = "/productType/all";
  List data;

  @override
  void initState() {
    _httpService = HttpService();
    getProductTypes();
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
              Text("Items"),
            ],
          ),
        ),
        elevation: .1,
        backgroundColor: Colors.black45,
      ),
      body: productList(),
    );
  }

  ListView productList() {
    return ListView.builder(
      itemCount: productTypes != null ? productTypes.length : 0,
      itemBuilder: (context, index) {
        return Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    print('tapped : ' + productTypes[index]['name']);
                    //todo: add going into page with productItem from selected Type
                  },
                  child: Card(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text(productTypes[index]['name']),
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void getProductTypes() async {
    final response = await _httpService.get(url: url);
    setState(() {
      productTypes = response['data'];
    });
  }

}
