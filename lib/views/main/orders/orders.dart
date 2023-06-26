import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_shop_admin/views/components/scroll_component.dart';

import '../../../constants/color.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../widgets/are_you_sure_dialog.dart';
import '../../widgets/loading_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Stream<QuerySnapshot> ordersStream =
      FirebaseFirestore.instance.collection('orders').snapshots();

  final _verticalScrollController = ScrollController();
  final _horizontalScrollController = ScrollController();

  // delete order
  Future<void> deleteOrder(String id) async {
    await FirebaseFirestore.instance.collection('orders').doc(id).delete();
  }

  // toggle order approval
  Future<void> toggleApproval(String id, bool status) async {
    await FirebaseFirestore.instance.collection('orders').doc(id).update(
      {
        'isApproved': !status,
      },
    );
  }

  void deleteDialog(String id) {
    areYouSureDialog(
      title: 'Delete order',
      content: 'Are you sure you want to delete order?',
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
              const Icon(Icons.shopping_cart_checkout),
              const SizedBox(width: 10),
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
                    DataColumn(label: Text('Customer Name')),
                    DataColumn(label: Text('Vendor Name')),
                    DataColumn(label: Text('Product Image')),
                    DataColumn(label: Text('Product Name')),
                    DataColumn(label: Text('Price')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Product Size')),
                    DataColumn(label: Text('Action')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: snapshot.data!.docs.map(
                    (item) {
                      return DataRow(
                        cells: [
                          // customer
                          DataCell(
                            FutureBuilder<String>(
                              future: FirebaseFirestore.instance
                                  .collection('customers')
                                  .doc(item['customerId'])
                                  .get()
                                  .then(
                                    (DocumentSnapshot doc) => doc['fullname'],
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

                          DataCell(
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item['prodImg'],
                                width: 50,
                              ),
                            ),
                          ),
                          DataCell(Text('${item['prodName']}')),
                          DataCell(Text('\$${item['prodPrice']}')),
                          DataCell(Text('${item['prodQuantity']}')),
                          DataCell(Text('${item['prodSize']}')),
                          DataCell(
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: item['isApproved']
                                    ? primaryColor
                                    : accentColor,
                              ),
                              onPressed: () => toggleApproval(
                                item['orderId'],
                                item['isApproved'],
                              ),
                              child: Text(
                                item['isApproved'] ? 'Reject' : 'Approve',
                              ),
                            ),
                          ),
                          DataCell(
                            ElevatedButton(
                              onPressed: () => deleteDialog(item['orderId']),
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
