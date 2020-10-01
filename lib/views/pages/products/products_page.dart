import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    _getProductTypes();
    _productsBloc = BlocProvider.of<ProductsBloc>(context);
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
                  _productsBloc.add(LoadedProductTypesEvent());
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
      body: productList(context),
    );
  }

  ListView productList(BuildContext context) {
    return ListView.builder(
      itemCount: products != null ? products.length : 0,
      itemBuilder: (context, index) {
        return listCard(index, context);
      },
    );
  }

  Widget listCard(
    int index,
    BuildContext context,
  ) {
    String price =
        products[index]['price'].toString() + " " + products[index]['currency'];
    return Card(
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
              Text(products[index]['name']),
              Spacer(),
              Text(price),
              SizedBox(width: 10),
              _productInfoButton(index),
            ],
          ),
        ),
        onTap: () => _selectedPositionDialog(products[index], context),
      ),
    );
  }

  InkWell _imageButton(int index) {
    return InkWell(
      child: Icon(Icons.image),
      onTap: () {
        var selectedProduct = products[index];
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
        var selectedProduct = products[index];
        _productInfoDialog(selectedProduct);
      },
    );
  }

  void _productInfoDialog(selectedProduct) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String dialogTitle = "About " + selectedProduct['name'];
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
    TextEditingController _controller = TextEditingController();
    _controller.text = "0";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(selectedProduct['name']),
          content: Row(
            children: <Widget>[
              Text("Amount: "),
              Spacer(),
              _minusButton(_controller),
              _numericField(_controller),
              _plusButton(_controller),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            _closeButton(context),
            _getCodeButton(_controller, context, selectedProduct),
            _addToCardButton(_controller, context, selectedProduct),
          ],
        );
      },
    );
  }

  FlatButton _closeButton(BuildContext context) {
    return FlatButton(
      child: Text("Close"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  FlatButton _addToCardButton(
    TextEditingController _controller,
    BuildContext context,
    dynamic selectedProduct,
  ) {
    return FlatButton(
      child: Text("Add to cart"),
      onPressed: () async {
        int selectedValue = int.parse(_controller.text);

        if (selectedValue > 0) {
          int productId = selectedProduct['id'];

          Map<String, dynamic> body = {
            "productId": productId,
            "quantity": selectedValue
          };

          String basketUrl = "/baskets_products/add";
          final response = await _httpService.post(url: basketUrl, body: body);

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
    TextEditingController _controller,
    BuildContext context,
    dynamic selectedProduct,
  ) {
    return FlatButton(
      child: Text("Get Code"),
      onPressed: () {
        int currentValue = int.parse(_controller.text);
        if (currentValue > 0) {
          print("Return barCode for position");
        }
        Navigator.of(context).pop();
      },
    );
  }

  Container _plusButton(TextEditingController _controller) {
    return Container(
      child: InkWell(
        child: Icon(
          Icons.add,
          size: 30.0,
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

  Container _minusButton(TextEditingController _controller) {
    return Container(
      child: InkWell(
        child: Icon(
          Icons.remove,
          size: 30.0,
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

  Widget _numericField(TextEditingController _controller) {
    return Expanded(
      child: TextFormField(
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

  void _getProductTypes() async {
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
