import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/views/pages/products/product_types_page.dart';
import 'package:smartmarktclient/views/pages/products/products_page.dart';

class ProductsPanel extends StatefulWidget {
  ProductsPanel();

  @override
  _ProductsPanelState createState() => _ProductsPanelState();
}

class _ProductsPanelState extends State<ProductsPanel> {
  ProductsBloc _productsBloc;
  RouteBloc _routeBloc;

  @override
  void initState() {
    _productsBloc = ProductsBloc();
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _productsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _routeBloc.add(LoadMainMenuEvent());
        return false;
      },
      child: Center(
        child: BlocProvider(
          create: (_) => _productsBloc,
          child: BlocListener<ProductsBloc, ProductsState>(
            listener: (context, state) {},
            child: BlocBuilder(
              cubit: _productsBloc,
              builder: (context, state) {
                if (state is ProductTypesState) {
                  return ProductTypesPage();
                } else if (state is SelectedTypeProductsState) {
                  return ProductPageWidget(
                    productType: state.productType,
                  );
                } else {
                  return Container(color: Colors.red);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  _routeBloc.add(LoadMainMenuEvent());
                },
              ),
              SizedBox(width: 20),
              Text("Product Types"),
            ],
          ),
        ),
        elevation: .1,
        backgroundColor: Colors.black45,
      ),
      body: Container(
        color: Colors.green,
      ),
    );
  }
}
