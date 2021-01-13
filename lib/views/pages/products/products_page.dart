import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/http/http_service.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class ProductsPage extends StatefulWidget {
  final Map productType;

  ProductsPage({
    this.productType,
  });

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Map<String, dynamic>> _products;
  List<Map<String, dynamic>> _newProducts;
  List<dynamic> selectedProducts = [];
  ProductsBloc _productsBloc;
  HttpService _httpService;
  final String url = "/products/typeId";
  List data;
  bool rememberMe = false;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _httpService = HttpService();
    _getProducts();
    _productsBloc = BlocProvider.of<ProductsBloc>(context);
    _controller = TextEditingController();
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
                  _productsBloc.add(LoadedProductTypesEvent());
                },
              ),
              SizedBox(width: 20),
              Text(widget.productType['name']),
            ],
          ),
        ),
        elevation: .1,
        backgroundColor: analogThree,
      ),
      body: productList(context),
    );
  }

  onItemChanged(String value) {
    setState(() {
      _newProducts = _products
          .where((productType) =>
              productType['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
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

  Widget productList(BuildContext context) {
    return Column(
      children: [
        _searchBar(),
        Expanded(
          child: Container(
            color: primaryColor,
            child: ListView.builder(
              itemCount: _newProducts != null ? _newProducts.length : 0,
              itemBuilder: (context, index) {
                return listCard(index, context);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget listCard(int index, BuildContext context) {
    Map<String, dynamic> product = _newProducts[index];
    String price = product['price'].toString() + " " + product['currency'];
    return Card(
      color: Colors.white,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Row(
            children: <Widget>[
              _imageButton(index),
              SizedBox(width: 10),
              Text(product['name']),
              Spacer(),
              Text(price),
              SizedBox(width: 10),
              _productInfoButton(index),
            ],
          ),
        ),
        onTap: () => _selectedPositionDialog(product, context),
      ),
    );
  }

  InkWell _imageButton(int index) {
    return InkWell(
      child: Icon(Icons.image),
      onTap: () {
        Map<String, dynamic> selectedProduct = _products[index];
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(selectedProduct['name']),
                content: Row(
                  children: [
                    Flexible(child: Text('image')),
                  ],
                ),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  _closeButton(context),
                ],
              );
            });
      },
    );
  }

  InkWell _productInfoButton(int index) {
    return InkWell(
      child: Icon(Icons.help_outline),
      onTap: () {
        Map<String, dynamic> selectedProduct = _products[index];
        _productInfoDialog(selectedProduct);
      },
    );
  }

  void _productInfoDialog(selectedProduct) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String dialogTitle = selectedProduct['name'];
        String productInfo = selectedProduct['productInfo'];
        return AlertDialog(
          title: Text(dialogTitle),
          content: Text(productInfo),
          actions: <Widget>[
            _closeButton(context),
          ],
        );
      },
    );
  }

  void _selectedPositionDialog(
    dynamic selectedProduct,
    BuildContext context,
  ) {
    _controller.text = "0";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Color(0xFF222222),
          title: Text(selectedProduct['name']),
          titleTextStyle: TextStyle(color: Colors.amber, fontSize: 20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _availabilityInfoRow(selectedProduct),
              SizedBox(height: 15),
              _quantityRow(),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            _closeButton(context),
            _getCodeButton(context, selectedProduct),
            _addToCardButton(context, selectedProduct),
          ],
        );
      },
    );
  }

  Row _quantityRow() {
    return Row(
      children: <Widget>[
        Text(
          "Ilość: ",
          style: TextStyle(color: Colors.white70),
        ),
        Spacer(),
        _minusButton(_controller),
        _numericField(_controller),
        _plusButton(_controller),
      ],
    );
  }

  Row _availabilityInfoRow(Map<String, dynamic> selectedProduct) {
    return Row(children: <Widget>[
      Text(
        "Dostępne: ",
        style: TextStyle(color: Colors.white70),
      ),
      Spacer(),
      Text(
        "${selectedProduct['quantity']} szt.",
        style: TextStyle(color: Colors.white70),
      ),
    ]);
  }

  FlatButton _closeButton(BuildContext context) {
    return FlatButton(
      child: Text("Zamknij"),
      textColor: Colors.amber,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  FlatButton _addToCardButton(
    BuildContext context,
    Map<String, dynamic> selectedProduct,
  ) {
    return FlatButton(
      child: Text("Dodaj do koszyka"),
      textColor: Colors.amber,
      onPressed: () async {
        int selectedValue = int.parse(_controller.text);

        if (selectedValue > 0) {
          int productId = selectedProduct['id'];

          Map<String, dynamic> body = {
            "productId": productId,
            "quantity": selectedValue
          };

          String basketUrl = "/baskets_products/add";
          final response =
              await _httpService.post(url: basketUrl, postBody: body);

          if (response['success'] == true) {
            print(response['data']['msg']);
          } else {
            print(response['statusCode']);
            print(response['data']['msg']);
          }
        }
        Navigator.of(context).pop();
      },
    );
  }

  FlatButton _getCodeButton(
    BuildContext context,
    Map<String, dynamic> selectedProduct,
  ) {
    return FlatButton(
      child: Text("Kod kreskowy"),
      textColor: Colors.amber,
      onPressed: () {
        int currentValue = int.parse(_controller.text);
        if (currentValue > 0) {
          print("Return barCode for position");
        }
        Navigator.of(context).pop();
      },
    );
  }

  Widget _numericField(TextEditingController _controller) {
    return Expanded(
      child: TextFormField(
        style: TextStyle(color: Colors.white70),
        readOnly: true,
        controller: _controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
    );
  }

  Container _minusButton(TextEditingController _controller) {
    return Container(
      child: InkWell(
        child: Icon(
          Icons.remove,
          size: 30.0,
          color: Colors.white70,
        ),
        onTap: () {
          int currentValue = int.parse(_controller.text);
          if (currentValue > 0) {
            setState(() {
              currentValue--;
              _controller.text =
                  (currentValue).toString(); // incrementing value
            });
          }
        },
      ),
    );
  }

  Container _plusButton(TextEditingController _controller) {
    return Container(
      child: InkWell(
        child: Icon(
          Icons.add,
          size: 30.0,
          color: Colors.white70,
        ),
        onTap: () {
          int currentValue = int.parse(_controller.text);
          setState(() {
            currentValue++;
            _controller.text = (currentValue).toString(); // incrementing value
          });
        },
      ),
    );
  }

  void _getProducts() async {
    Map<String, dynamic> body = {
      "id": widget.productType['id'],
    };
    Map<String, dynamic> response =
        await _httpService.post(url: url, postBody: body);
    setState(() {
      _products = new List<Map<String, dynamic>>.from(response['data']);
      _newProducts = _products;
      _products.forEach((element) {
        selectedProducts.add(false);
      });
    });
  }
}
