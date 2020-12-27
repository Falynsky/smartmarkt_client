import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';
import 'package:smartmarktclient/http/http_service.dart';

class ProductTypesPage extends StatefulWidget {
  @override
  _ProductTypesPageState createState() => _ProductTypesPageState();
}

class _ProductTypesPageState extends State<ProductTypesPage> {
  List<dynamic> productTypes;
  ProductsBloc _productsBloc;

  HttpService _httpService;
  final String url = "/productType/all";
  List data;

  @override
  void initState() {
    _httpService = HttpService();
    getProductTypes();
    _productsBloc = BlocProvider.of<ProductsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: PagesAppBar(title: "Kategorie"),
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
                    var productType = productTypes[index];
                    print('tapped : ' + productType['name']);
                    _productsBloc.add(
                      SelectedTypeProductsEvent(
                        productType: productType,
                      ),
                    );
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
