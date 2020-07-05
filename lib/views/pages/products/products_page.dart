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
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            children: <Widget>[
              Icon(Icons.image),
              Spacer(),
              Text(products[index]['name']),
              Spacer(),
              SizedBox(width: 10),
              _productInfoButton(index),
            ],
          ),
        ),
        onTap: () {
          var selectedProduct = products[index];
          _selectedPositionDialog(selectedProduct);
          print('tapped : ' + selectedProduct['name']);
        },
      ),
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
        // return object of type Dialog
        return AlertDialog(
          title: Text("About" + selectedProduct['name']),
          content: Row(
            children: <Widget>[
              Text("This is a great product!"),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            _closeButton(context),
          ],
        );
      },
    );
  }

  void _selectedPositionDialog(selectedProduct) {
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
            _getCodeButton(_controller, context),
            _addToCardButton(_controller, context),
          ],
        );
      },
    );
  }

  FlatButton _closeButton(BuildContext context) {
    return FlatButton(
      child: new Text("Close"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  FlatButton _addToCardButton(
      TextEditingController _controller, BuildContext context) {
    return FlatButton(
      child: new Text("Add to cart"),
      onPressed: () {
        int currentValue = int.parse(_controller.text);
        if (currentValue > 0) {
          print("Add to card selected position");
        }
        Navigator.of(context).pop();
      },
    );
  }

  FlatButton _getCodeButton(
      TextEditingController _controller, BuildContext context) {
    return FlatButton(
      child: new Text("Get Code"),
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
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
      ),
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
