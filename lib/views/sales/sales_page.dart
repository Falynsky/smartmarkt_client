import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';
import 'package:smartmarktclient/models/sale.dart';
import 'package:smartmarktclient/utilities/circular_idicator.dart';
import 'package:smartmarktclient/utilities/colors.dart';
import 'package:smartmarktclient/views/empty_list_screen.dart';
import 'package:smartmarktclient/views/sales/sales_position.dart';

class SalesPage extends StatefulWidget {
  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
late RouteBloc _routeBloc;
late SalesBloc _salesBloc;
late bool _isLoaded;
late List<Sale> _newSales;

  @override
  void initState() {
    super.initState();
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    _salesBloc = SalesBloc();
    _isLoaded = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _routeBloc.add(LoadMainMenuEvent());
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: PagesAppBar(title: "Promocje"),
        ),
        body: BlocProvider(
          create: (_) => _salesBloc..add(SalesLoadingEvent()),
          child: BlocListener<SalesBloc, SalesState>(
            listener: (context, state) {
              if (state is SalesLoadingState) {
                _isLoaded = false;
              } else if (state is LoadedSalesState) {
                _isLoaded = true;
                _newSales = state.sales;
              }
              setState(() {});
            },
            child: _salesPage(context),
          ),
        ),
      ),
    );
  }

  Widget _salesPage(BuildContext context) {
    if (!_isLoaded) {
      return CircularIndicator();
    }

    return _salesComponent();
  }

  Widget _salesComponent() {
    var salesNotExists = !_newSales.isNotEmpty;
    return Container(
      color: primaryColor,
      child: Column(
        children: [
          _searchBar(),
          if (salesNotExists) EmptyListScreen(msg: "Brak promocji"),
          if (!salesNotExists) _salesList(),
        ],
      ),
    );
  }

  Widget _searchBar() {
    TextEditingController? _textEditingController;
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

  onItemChanged(String input) {
    setState(() {
      _newSales = _salesBloc.sales.where((sale) {
        final lowerCaseTitle = sale.title.toLowerCase();
        final lowerCaseInput = input.toLowerCase();
        return lowerCaseTitle.contains(lowerCaseInput);
      }).toList();
    });
  }

  Widget _salesList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _newSales.length,
        itemBuilder: (context, index) {
          Sale sale = _newSales[index];
          return SalesPosition(sale: sale);
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _salesBloc.close();
  }
}
