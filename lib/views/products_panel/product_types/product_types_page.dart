import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';
import 'package:smartmarktclient/models/product_type.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class ProductTypesPage extends StatefulWidget {
  @override
  _ProductTypesPageState createState() => _ProductTypesPageState();
}

class _ProductTypesPageState extends State<ProductTypesPage> {
  late ProductsPanelBloc _productsPanelBloc;
  late ProductTypesBloc _productTypesBloc;
  late List<ProductType> newProductTypes;

  @override
  void initState() {
    super.initState();
    _productsPanelBloc = BlocProvider.of<ProductsPanelBloc>(context);
    _productTypesBloc = ProductTypesBloc();
    newProductTypes = <ProductType>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: PagesAppBar(title: "Kategorie"),
      ),
      body: BlocProvider(
        create: (_) => _productTypesBloc..add(InitialProductTypesEvent()),
        child: BlocListener<ProductTypesBloc, ProductTypesState>(
          listener: (context, state) {
            if (state is LoadedProductTypesState) {
              newProductTypes = _productTypesBloc.productTypes;
            }
            setState(() {});
          },
          child: productList(),
        ),
      ),
    );
  }

  Widget productList() {
    return Column(
      children: [
        _searchBar(),
        _productTypesList(),
      ],
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

  onItemChanged(String value) {
    setState(() {
      newProductTypes = _productTypesBloc.productTypes
          .where((productType) =>
              productType.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  Widget _productTypesList() {
    return Expanded(
      child: Container(
        color: primaryColor,
        child: ListView.builder(
          itemCount: newProductTypes.length,
          itemBuilder: (context, index) {
            return _productTypeCard(index);
          },
        ),
      ),
    );
  }

  Widget _productTypeCard(int index) {
    return Container(
      child: InkWell(
        child: Card(
          color: Colors.white,
          child: Container(
            child: Text(
              newProductTypes[index].name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            padding: EdgeInsets.all(20),
          ),
        ),
        onTap: () {
          _goToProductsList(index);
        },
      ),
    );
  }

  void _goToProductsList(int index) {
    ProductType productType = newProductTypes[index];
    final emitSelectedTypeProductsEvent =
        SelectedTypeProductsEvent(productType: productType);
    _productsPanelBloc.add(emitSelectedTypeProductsEvent);
  }
}
