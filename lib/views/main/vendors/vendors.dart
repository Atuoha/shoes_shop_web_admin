import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';

class VendorsScreen extends StatefulWidget {
  const VendorsScreen({Key? key}) : super(key: key);

  @override
  State<VendorsScreen> createState() => _VendorsScreenState();
}

class _VendorsScreenState extends State<VendorsScreen> {
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
              const Icon(Icons.group),
              const SizedBox(width: 10),
              Text(
                'Vendors',
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
              DataColumn(label: Text('Vendor Name')),
              DataColumn(label: Text('Vendor Image')),
              DataColumn(label: Text('City')),
              DataColumn(label: Text('State')),
              DataColumn(label: Text('Country')),
              DataColumn(label: Text('Email Address')),
              DataColumn(label: Text('Action')),
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(Text('Josh Stores')),
                  DataCell(
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        AssetManager.placeholderImg,
                        width: 50,
                      ),
                    ),
                  ),
                  DataCell(Text('Owerri')),
                  DataCell(Text('Imo State')),
                  DataCell(Text('Nigeria')),
                  DataCell(Text('joshstores@gmail.com')),
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
