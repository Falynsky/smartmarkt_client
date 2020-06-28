import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/http/http_service.dart';

class ProductPageWidget extends StatefulWidget {
  final Map productType;

  ProductPageWidget({
    this.productType,
  });

  @override
  _ProductPageWidgetState createState() => _ProductPageWidgetState();
}

class _ProductPageWidgetState extends State<ProductPageWidget> {
  List<dynamic> products;
  List<dynamic> selectedProducts = [];
  ProductsBloc _productsBloc;
  HttpService _httpService;
  final String url = "/products/typeId";
  List data;
  bool rememberMe = false;

  @override
  void initState() {
    _httpService = HttpService();
    _productsBloc = BlocProvider.of<ProductsBloc>(context);
    getProductTypes();
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
                    _productsBloc.add(ProductTypesEvent());
                  });
                },
              ),
              SizedBox(width: 20),
              Text(widget.productType['name']),
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
        return listCard(index);
      },
    );
  }

  Widget listCard(int index) {
    return Card(
      child: InkWell(
        onTap: () {
          var productType = products[index];
          print('tapped : ' + productType['name']);
        },
        child: Container(
          padding: EdgeInsets.only(right: 10),
          child: Row(
            children: <Widget>[
              _checkBox(index),
              Text(products[index]['name']),
              Spacer(),
              Text('quantity: ' + products[index]['quantity'].toString()),
            ],
          ),
        ),
      ),
    );
  }

  Checkbox _checkBox(int index) {
    return Checkbox(
      value: selectedProducts[index],
      onChanged: (bool newValue) {
        setState(() {
          selectedProducts[index] = newValue;
        });
      },
    );
  }

  void getProductTypes() async {
    Map<String, dynamic> body = {
      "id": widget.productType['id'],
    };
    final response = await _httpService.post(url: url, body: body);
    setState(() {
      products = response['data'];
      products.forEach((element) {
        selectedProducts.add(false);
      });
    });
  }
}
