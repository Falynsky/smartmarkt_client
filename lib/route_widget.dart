import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/views/pages/basket/basket_page.dart';
import 'package:smartmarktclient/views/pages/login/login_page.dart';
import 'package:smartmarktclient/views/pages/main_page.dart';
import 'package:smartmarktclient/views/pages/products/products_panel.dart';
import 'package:smartmarktclient/views/pages/register/sign_up_page.dart';
import 'package:smartmarktclient/views/pages/sales/sales_page.dart';
import 'package:smartmarktclient/views/pages/scan_shop/configurator_page.dart';
import 'package:smartmarktclient/views/pages/scanner/scanner_page.dart';

class RouteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RouteBloc(),
      child: BlocListener<RouteBloc, RouteState>(
        listener: (context, state) {},
        child: BlocBuilder<RouteBloc, RouteState>(
          builder: (context, state) {
            if (state is ConfigurePageState) {
              return ConfiguratorPage();
            } else if (state is LoginPageState) {
              return LoginPage();
            } else if (state is SignUpPageState) {
              return SignUpPage();
            } else if (state is LoadMainMenuState) {
              return MainPage();
            } else if (state is LoadDashboardPageState) {
              String pageIdn = state.pageIdn;
              if (pageIdn == 'products') {
                return ProductsPanel();
              } else if (pageIdn == 'scanner') {
                return ScannerPage();
              } else if (pageIdn == 'sales') {
                return SalesPage();
              } else if (pageIdn == 'basket') {
                return BasketPage();
              } else {
                return Container(color: Colors.red);
              }
            } else {
              return Container(color: Colors.red);
            }
          },
        ),
      ),
    );
  }
}
