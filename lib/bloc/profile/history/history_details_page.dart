import 'package:flutter/material.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class HistoryDetailsPage extends StatelessWidget {
  final List<Map<String, dynamic>> productsList;
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
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              color: Colors.white70,
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
            ),
            Divider(height: 0, thickness: 2),
            buildDetailsPage(),
          ],
        ),
      ),
    );
  }

  Flexible flexibleText(String text) {
    return Flexible(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      ),
    );
  }

  Widget buildDetailsPage() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 70),
        itemCount: productsList != null ? productsList.length : 0,
        itemBuilder: (context, index) {
          return listCard(context, index);
        },
      ),
    );
  }

  Widget listCard(BuildContext context, int index) {
    Map<String, dynamic> product = productsList[index];
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              product["productName"],
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                Text("${product["quantity"]} szt."),
                SizedBox(width: 10),
                Text("${product["purchasedPrice"]} zł"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
