import 'package:flutter/material.dart';
import 'package:shoes_shop_admin/resources/assets_manager.dart';

import '../../../constants/color.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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
              const Icon(Icons.shopping_bag),
              const SizedBox(width: 10),
              Text(
                'Products',
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
              DataColumn(label: Text('Product Name')),
              DataColumn(label: Text('Product Image')),
              DataColumn(label: Text('Product Price')),
              DataColumn(label: Text('Product Quantity')),
              DataColumn(label: Text('Action')),
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(Text('Product Name')),
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
                  DataCell(Text('11')),
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
