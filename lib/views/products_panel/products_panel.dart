import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/views/products_panel/product_types/product_types_page.dart';
import 'package:smartmarktclient/views/products_panel/products/products_page.dart';

class ProductsPanel extends StatefulWidget {
  ProductsPanel();

  @override
  _ProductsPanelState createState() => _ProductsPanelState();
}

class _ProductsPanelState extends State<ProductsPanel> {
  ProductsPanelBloc _productsBloc;
  RouteBloc _routeBloc;

  @override
  void initState() {
    _productsBloc = ProductsPanelBloc();
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
          child: BlocListener<ProductsPanelBloc, ProductsPanelState>(
            listener: (context, state) {},
            child: BlocBuilder(
              cubit: _productsBloc,
              builder: (context, state) {
                if (state is ProductTypesPageState) {
                  return ProductTypesPage();
                } else if (state is SelectedTypeProductsState) {
                  return ProductsPage(productType: state.productType);
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
}
