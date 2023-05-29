import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(Icons.shopping_cart_checkout),
              const SizedBox(width:10),
              Text(
                'Orders',
                style: getMediumStyle(
                  color: Colors.black,
                  fontSize: FontSize.s16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          DataTable(
            showBottomBorder: true,
            headingRowColor:
                MaterialStateColor.resolveWith((states) => primaryColor),
            headingTextStyle: const TextStyle(color: Colors.white),
            dataRowHeight: 60,
            columns: const [
              DataColumn(label: Text('Full Name')),
              DataColumn(label: Text('Product Image')),
              DataColumn(label: Text('Price')),
              DataColumn(label: Text('City')),
              DataColumn(label: Text('State')),
              DataColumn(label: Text('Action')),
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(Text('Josh Doe')),
                  DataCell(
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        AssetManager.placeholderImg,
                        width: 50,
                      ),
                    ),
                  ),
                  DataCell(Text('\$66.00')),
                  DataCell(Text('Owerri')),
                  DataCell(Text('Imo State')),
                  DataCell(ElevatedButton(
                    onPressed: null,
                    child: Text('Reject'),
                  )),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
