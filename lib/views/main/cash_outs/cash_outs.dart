import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';

class CashOutScreen extends StatefulWidget {
  const CashOutScreen({Key? key}) : super(key: key);

  @override
  State<CashOutScreen> createState() => _CashOutScreenState();
}

class _CashOutScreenState extends State<CashOutScreen> {
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
              const Icon(Icons.monetization_on),
              const SizedBox(width: 10),
              Text(
                'Cash Outs',
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
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Amount')),
              DataColumn(label: Text('Bank Name')),
              DataColumn(label: Text('Account Number')),
              DataColumn(label: Text('Email Address')),
              DataColumn(label: Text('Phone Number')),
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(Text('Josh Doe')),
                  DataCell(Text('\$89.00')),
                  DataCell(Text('First Bank')),
                  DataCell(Text('1020401130')),
                  DataCell(Text('joshstores@gmail.com')),
                  DataCell(Text('+23481234990458')),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
