import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/views/pages/basket_page.dart';
import 'package:smartmarktclient/views/pages/login_page.dart';
import 'package:smartmarktclient/views/pages/main_page.dart';
import 'package:smartmarktclient/views/pages/products/products_panel.dart';
import 'package:smartmarktclient/views/pages/profile_page.dart';
import 'package:smartmarktclient/views/pages/register/sign_up_page.dart';
import 'package:smartmarktclient/views/pages/sales_page.dart';
import 'package:smartmarktclient/views/pages/scanner/scanner_page.dart';
import 'package:smartmarktclient/views/pages/settings_page.dart';

class RouteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RouteBloc(),
      child: BlocListener<RouteBloc, RouteState>(
        listener: (context, state) {},
        child: BlocBuilder<RouteBloc, RouteState>(
          builder: (context, state) {
            if (state is LoadLoginPageState) {
              return LoginPage();
            } else if (state is SignUpPageState) {
              return SignUpPage();
            } else if (state is LoadMainMenuState) {
              return MainPage();
            } else if (state is LoadDashboardPageState) {
              if (state.pageIdn == 'products') {
                return ProductsPanel();
              } else if (state.pageIdn == 'scanner') {
                return ScannerPage();
              } else if (state.pageIdn == 'sales') {
                return SalesPage();
              } else if (state.pageIdn == 'basket') {
                return BasketPage();
              } else if (state.pageIdn == 'profile') {
                return ProfilePage();
              } else if (state.pageIdn == 'settings') {
                return SettingsPage();
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
