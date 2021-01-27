import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';
import 'package:smartmarktclient/http/http_service.dart';
import 'package:smartmarktclient/models/sale.dart';
import 'package:smartmarktclient/utilities/circular_idicator.dart';
import 'package:smartmarktclient/utilities/colors.dart';
import 'package:smartmarktclient/views/products_panel/products/large_image_dialog.dart';

class SalesPage extends StatefulWidget {
  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  RouteBloc _routeBloc;
  SalesBloc _salesBloc;
  bool _isLoaded;
  List<Sale> _newSales;

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
    if (_newSales != null && _newSales.isNotEmpty) {
      return Container(
        color: primaryColor,
        child: Column(
          children: [
            _searchBar(),
            Expanded(
              child: ListView.builder(
                itemCount: _newSales != null ? _newSales.length : 0,
                itemBuilder: (context, index) {
                  return _salesTypeCard(index);
                },
              ),
            ),
          ],
        ),
      );
    }
    return Container(
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
              "Brak promocji",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: shadesThree,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _salesTypeCard(int index) {
    Sale _sale = _newSales[index];
    return Container(
      child: InkWell(
        onTap: () {},
        child: Card(
          color: Colors.white,
          child: Container(
            child: Row(
              children: [
                _imageButton(index),
                SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${_sale.title}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text("${_sale.description}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          )),
                      SizedBox(height: 10),
                      if (_sale.discount != null) _salePricesRow(_sale, index),
                    ],
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.all(20),
          ),
        ),
      ),
    );
  }

  Widget _salePricesRow(Sale _sale, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Rabat: ${_sale.discount * 100}%"),
        Row(
          children: <Widget>[
            Text("Cena: "),
            Text(
              "${_sale.originalPrice} zł",
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.red,
                decorationThickness: 2,
              ),
            ),
            SizedBox(width: 10),
            Text("${_afterDiscountRounded(_sale, index)} zł"),
          ],
        ),
      ],
    );
  }

  InkWell _imageButton(int index) {
    Sale sale = _newSales[index];
    String documentUrl =
        '${HttpService.hostUrl}/files/download/${sale.docName}.${sale.docType}/db';
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

  String _afterDiscountRounded(Sale sale, int index) {
    return (sale.originalPrice * (1 - sale.discount)).toStringAsFixed(2);
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

  onItemChanged(String input) {
    setState(() {
      _newSales = _salesBloc.sales.where((sale) {
        final lowerCaseTitle = sale.title.toLowerCase();
        final lowerCaseInput = input.toLowerCase();
        return lowerCaseTitle.contains(lowerCaseInput);
      }).toList();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _salesBloc.close();
  }
}
