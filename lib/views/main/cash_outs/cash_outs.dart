import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../components/scroll_component.dart';
import '../../widgets/are_you_sure_dialog.dart';
import '../../widgets/loading_widget.dart';
import 'package:intl/intl.dart' as intl;

class CashOutScreen extends StatefulWidget {
  const CashOutScreen({Key? key}) : super(key: key);

  @override
  State<CashOutScreen> createState() => _CashOutScreenState();
}

class _CashOutScreenState extends State<CashOutScreen> {
  Stream<QuerySnapshot> ordersStream =
      FirebaseFirestore.instance.collection('cash_outs').snapshots();

  final _verticalScrollController = ScrollController();
  final _horizontalScrollController = ScrollController();

  // delete order
  Future<void> deleteOrder(String id) async {
    await FirebaseFirestore.instance.collection('cash_outs').doc(id).delete();
  }

  // toggle order approval
  Future<void> toggleApproval(
    String id,
    bool status,
    double amount,
    String vendorId,
  ) async {
    await FirebaseFirestore.instance.collection('cash_outs').doc(id).update(
      {
        'status': !status,
      },
    ).whenComplete(() async {
      if (status) {
        // incrementing vendor's balance with amount
        FirebaseFirestore.instance
            .collection('vendors')
            .doc(vendorId)
            .get()
            .then((DocumentSnapshot data) {
          FirebaseFirestore.instance
              .collection('vendors')
              .doc(vendorId)
              .update({
            'balanceAvailable': data['balanceAvailable'] + amount,
          });
        });
      } else {
        // decrementing vendor's balance by balance
        FirebaseFirestore.instance
            .collection('vendors')
            .doc(vendorId)
            .get()
            .then((DocumentSnapshot data) {
          FirebaseFirestore.instance
              .collection('vendors')
              .doc(vendorId)
              .update({
            'balanceAvailable': data['balanceAvailable'] - amount,
          });
        });
      }
    });
  }

  void deleteDialog(String id) {
    areYouSureDialog(
      title: 'Delete cash out',
      content: 'Are you sure you want to delete cash out?',
      context: context,
      action: deleteOrder,
      isIdInvolved: true,
      id: id,
    );
  }

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
          StreamBuilder<QuerySnapshot>(
            stream: ordersStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                const Center(
                  child: Text('Error occurred!'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                const Center(
                  child: LoadingWidget(),
                );
              }

              if (!snapshot.hasData || snapshot.data == null) {
                ErrorWidget.builder =
                    (FlutterErrorDetails details) => const Center(
                          child: LoadingWidget(),
                        );
              }

              if (snapshot.data!.docs.isEmpty) {
                Center(
                  child: Image.asset(AssetManager.noImagePlaceholderImg),
                );
              }

              return ScrollComponent(
                horizontalScrollController: _horizontalScrollController,
                verticalScrollController: _verticalScrollController,
                child: DataTable(
                  showBottomBorder: true,
                  headingRowColor:
                      MaterialStateColor.resolveWith((states) => primaryColor),
                  headingTextStyle: const TextStyle(color: Colors.white),
                  dataRowHeight: 60,
                  columns: const [
                    DataColumn(label: Text('Vendor Name')),
                    DataColumn(label: Text('Amount')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Action')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: snapshot.data!.docs.map(
                    (item) {
                      return DataRow(
                        cells: [
                          //vendor
                          DataCell(
                            FutureBuilder<String>(
                              future: FirebaseFirestore.instance
                                  .collection('vendors')
                                  .doc(item['vendorId'])
                                  .get()
                                  .then(
                                    (DocumentSnapshot doc) => doc['storeName'],
                                  ),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Text('Error occurred!');
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  if (!snapshot.hasData ||
                                      snapshot.data == null) {
                                    ErrorWidget.builder =
                                        (FlutterErrorDetails details) =>
                                            const Center(
                                              child: LoadingWidget(),
                                            );
                                  }
                                }

                                return Text(snapshot.data ?? '');
                              },
                            ),
                          ),

                          DataCell(Text('\$${item['amount']}')),
                          DataCell(
                            Text(
                              intl.DateFormat.yMMMEd().format(
                                item['date'].toDate(),
                              ),
                            ),
                          ),
                          DataCell(
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    item['status'] ? primaryColor : accentColor,
                              ),
                              onPressed: () => toggleApproval(
                                  item['id'],
                                  item['status'],
                                  item['amount'],
                                  item['vendorId']),
                              child: Text(
                                item['status'] ? 'Reject' : 'Approve',
                              ),
                            ),
                          ),
                          DataCell(
                            ElevatedButton(
                              onPressed: () => deleteDialog(item['id']),
                              child: const Text('Delete'),
                            ),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
