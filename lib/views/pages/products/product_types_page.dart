import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';
import 'package:smartmarktclient/http/http_service.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class ProductTypesPage extends StatefulWidget {
  @override
  _ProductTypesPageState createState() => _ProductTypesPageState();
}

class _ProductTypesPageState extends State<ProductTypesPage> {
  List<dynamic> productTypes;
  List<dynamic> newProductTypes;
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
      newProductTypes = productTypes;
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

  onItemChanged(String value) {
    setState(() {
      newProductTypes = productTypes
          .where((productType) =>
              productType['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  Widget productList() {
    return Column(
      children: [
        _searchBar(),
        Expanded(
          child: Container(
            color: primaryColor,
            child: ListView.builder(
              itemCount: newProductTypes != null ? newProductTypes.length : 0,
              itemBuilder: (context, index) {
                return _productTypeCard(index);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _searchBar() {
    TextEditingController _textEditingController;
    return Container(
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search_rounded),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(5.0),
              ),
            ),
            hintText: 'Wyszukaj...',
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: onItemChanged,
        ),
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
          color: Colors.white,
          child: Container(
            child: Text(newProductTypes[index]['name']),
            padding: EdgeInsets.all(20),
          ),
        ),
      ),
    );
  }

  void _goToProductsList(int index) {
    Map<String, dynamic> productType = newProductTypes[index];
    final emitSelectedTypeProductsEvent =
        SelectedTypeProductsEvent(productType: productType);
    _productsBloc.add(emitSelectedTypeProductsEvent);
  }
}
