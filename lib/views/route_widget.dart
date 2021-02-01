import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/views/basket/basket_page.dart';
import 'package:smartmarktclient/views/configurator/configurator_page.dart';
import 'package:smartmarktclient/views/login/login_page.dart';
import 'package:smartmarktclient/views/main/main_page.dart';
import 'package:smartmarktclient/views/products_panel/products_panel.dart';
import 'package:smartmarktclient/views/profile/profile_page.dart';
import 'package:smartmarktclient/views/register/sign_up_page.dart';
import 'package:smartmarktclient/views/sales/sales_page.dart';
import 'package:smartmarktclient/views/scanner/scanner_page.dart';

class RouteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RouteBloc(),
      child: BlocBuilder<RouteBloc, RouteState>(
        builder: (context, state) {
          if (state is ConfigurePageState) {
            return ConfiguratorPage();
          } else if (state is LoginPageState) {
            return LoginPage();
          } else if (state is SignUpPageState) {
            return SignUpPage();
          } else if (state is LoadProfilePageState) {
            return ProfilePage();
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
    );
  }
}
