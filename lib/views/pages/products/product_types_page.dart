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
    super.initState();
    _productsBloc = BlocProvider.of<ProductsBloc>(context);
    _httpService = HttpService();
    _getProductTypes();
  }

  void _getProductTypes() async {
    final response = await _httpService.get(url: url);
    setState(() {
      productTypes = response['data'];
    });
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

  Widget productList() {
    return Container(
      color: Color(0xFF40c5ba),
      child: ListView.builder(
        itemCount: productTypes != null ? productTypes.length : 0,
        itemBuilder: (context, index) {
          return _productTypeCard(index);
        },
      ),
    );
  }

  Widget _productTypeCard(int index) {
    return Container(
      child: InkWell(
        onTap: () {
          _goToProductsList(index);
        },
        child: Card(
          color: Color(0xFFDDDDDD),
          child: Container(
            child: Text(productTypes[index]['name']),
            padding: EdgeInsets.all(20),
          ),
        ),
      ),
    );
  }

  void _goToProductsList(int index) {
    Map<String, dynamic> productType = productTypes[index];
    final emitSelectedTypeProductsEvent =
        SelectedTypeProductsEvent(productType: productType);
    _productsBloc.add(emitSelectedTypeProductsEvent);
  }
}
