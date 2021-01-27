import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/http/http_service.dart';
import 'package:smartmarktclient/models/product.dart';
import 'package:smartmarktclient/models/product_type.dart';
import 'package:smartmarktclient/utilities/colors.dart';
import 'package:smartmarktclient/views/products_panel/products/product_info_dialog.dart';

import 'large_image_dialog.dart';

class ProductsPage extends StatefulWidget {
  final ProductType productType;

  ProductsPage({@required this.productType});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  ProductsPanelBloc _productsPanelBloc;
  ProductsBloc _productsBloc;
  List<Product> _newProducts;
  List data;
  bool rememberMe = false;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _productsPanelBloc = BlocProvider.of<ProductsPanelBloc>(context);
    _productsBloc = ProductsBloc();
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
                  _productsPanelBloc.add(LoadedProductTypesPageEvent());
                },
              ),
              SizedBox(width: 20),
              Text(widget.productType.name),
            ],
          ),
        ),
        shadowColor: Colors.black87,
        elevation: 6,
        backgroundColor: analogThree,
      ),
      body: BlocProvider(
        create: (_) => _productsBloc
          ..add(InitialProductsEvent(productTypeId: widget.productType.id)),
        child: BlocListener<ProductsBloc, ProductsState>(
          listener: (context, state) {
            if (state is LoadedProductsState) {
              _newProducts = _productsBloc.products;
            } else if (state is AddToBasketSucceedState) {
              Navigator.of(context).pop();
            } else if (state is AddToBasketUnSucceedState) {
              final snackBar = SnackBar(
                content: Text(state.msg),
                behavior: SnackBarBehavior.floating,
                backgroundColor: complementaryThree,
                action: SnackBarAction(
                  label: "OK",
                  onPressed: () => {},
                  textColor: Colors.black54,
                ),
              );
              Scaffold.of(context).showSnackBar(snackBar);
              Navigator.of(context).pop();
            }
            setState(() {});
          },
          child: productList(context),
        ),
      ),
    );
  }

  Widget productList(BuildContext context) {
    return Column(
      children: [
        _searchBar(),
        if (_newProducts != null && _newProducts.isNotEmpty)
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
        if (_newProducts == null || _newProducts.isEmpty)
          Expanded(
            child: Container(
              color: primaryColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.format_list_bulleted_rounded,
                      size: 100,
                      color: shadesThree,
                    ),
                    Text(
                      "Brak produktów",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: shadesThree,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }

  onItemChanged(String value) {
    setState(() {
      _newProducts = _productsBloc.products
          .where((productType) =>
              productType.name.toLowerCase().contains(value.toLowerCase()))
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

  Widget listCard(int index, BuildContext context) {
    Product product = _newProducts[index];
    String price = product.price.toString() + " zł";
    return Card(
      color: Colors.white,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _imageButton(index),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  product.name,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
              ),
              Spacer(),
              Text(
                price,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              SizedBox(width: 10),
              _productAddButton(index),
            ],
          ),
        ),
        onTap: () => ProductInfoDialog().showDialogBox(context, product),
      ),
    );
  }

  InkWell _imageButton(int index) {
    Product products = _newProducts[index];
    String documentUrl =
        '${HttpService.hostUrl}/files/download/${products.documentName}.${products.documentType}/db';
    return InkWell(
      child: Image.network(
        '$documentUrl/70/70',
        headers: HttpService.headers,
        errorBuilder: (_, __, ___) {
          return Icon(Icons.image_not_supported);
        },
      ),
      onTap: () => LargeImageDialog().showDialogBox(context, documentUrl),
    );
  }

  InkWell _productAddButton(int index) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.add_circle_outline_rounded),
      ),
      onTap: () {
        Product selectedProduct = _productsBloc.products[index];
        _selectedPositionDialog(selectedProduct);
      },
    );
  }

  void _selectedPositionDialog(Product selectedProduct) {
    _controller.text = "0";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: shadesThree,
          title: Text(selectedProduct.name),
          titleTextStyle: TextStyle(color: complementaryThree, fontSize: 20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _availabilityInfoRow(selectedProduct),
              SizedBox(height: 15),
              _quantityRow(),
            ],
          ),
          actions: <Widget>[
            _closeButton(context),
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

  Row _availabilityInfoRow(Product selectedProduct) {
    return Row(children: <Widget>[
      Text("Dostępne: ", style: TextStyle(color: Colors.white70)),
      Spacer(),
      Text(
        "${selectedProduct.quantity} szt.",
        style: TextStyle(color: Colors.white70),
      ),
    ]);
  }

  FlatButton _closeButton(BuildContext context) {
    return FlatButton(
      child: Text("Zamknij"),
      textColor: complementaryThree,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  FlatButton _addToCardButton(
    BuildContext context,
    Product product,
  ) {
    return FlatButton(
      child: Text("Dodaj do koszyka"),
      textColor: complementaryThree,
      onPressed: () async {
        int quantity = int.parse(_controller.text);
        if (quantity > 0) {
          final addToBasketEvent = AddToBasketEvent(
            productId: product.id,
            quantity: quantity,
          );
          _productsBloc.add(addToBasketEvent);
        }
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
}
