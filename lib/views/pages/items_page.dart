import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:smartmarktclient/bloc/bloc.dart';

class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  List<dynamic> products;

  RouteBloc _routeBloc;

  final String url = "https://192.168.0.161:8443/products/all";
  List data;

  @override
  void initState() {
    this.getJsonData();
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
      itemCount: products != null ? products.length : 0,
      itemBuilder: (context, index) {
        return Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Name: '+products[index]['name']),
                        Text('Quantity: '+products[index]['quantity'].toString()),
                      ],
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> getJsonData() async {
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = new IOClient(httpClient);

    final response = await ioClient.get(
      '$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        //HttpHeaders.authorizationHeader: '',
      },
    );
    setState(() {
      products = jsonDecode(response.body);
    });
  }
}
