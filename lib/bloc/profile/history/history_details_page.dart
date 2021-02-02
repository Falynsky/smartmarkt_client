import 'package:flutter/material.dart';
import 'package:smartmarktclient/models/product_history.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class HistoryDetailsPage extends StatelessWidget {
  final List<ProductHistory> productsList;
  final String purchasedDate;
  final String productSummary;

  HistoryDetailsPage({
    @required this.productsList,
    @required this.purchasedDate,
    @required this.productSummary,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Podsumowanie zakupu"),
        backgroundColor: analogThree,
      ),
      backgroundColor: primaryColor,
      body: Container(
        child: Column(
          children: [
            _historyDetailsHeader(),
            Divider(height: 0, thickness: 3, color: Colors.black45),
            _buildDetailsPage(),
          ],
        ),
      ),
    );
  }

  Container _historyDetailsHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          flexibleText("Data zakupu:"),
          SizedBox(width: 5),
          Text(purchasedDate),
          SizedBox(width: 10),
          flexibleText("Podsumowanie:"),
          SizedBox(width: 5),
          Text("$productSummary zł"),
        ],
      ),
    );
  }

  Widget flexibleText(String text) {
    return Flexible(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      ),
    );
  }

  Widget _buildDetailsPage() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 2),
        color: complementaryThree.withOpacity(0.7),
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 70),
          itemCount: productsList != null ? productsList.length : 0,
          itemBuilder: (context, index) {
            return listCard(context, index);
          },
        ),
      ),
    );
  }

  Widget listCard(BuildContext context, int index) {
    ProductHistory product = productsList[index];
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              product.productName,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                Text("${product.quantity} szt."),
                SizedBox(width: 10),
                Text("${product.purchasedPrice} zł"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
