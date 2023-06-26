import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../widgets/loading_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Stream<QuerySnapshot> ordersStream =
      FirebaseFirestore.instance.collection('orders').snapshots();

  // get customer fullname
  Future<String> getCustomerName(String customerId) async {
    String customerName = '';
    await FirebaseFirestore.instance
        .collection('customers')
        .doc(customerId)
        .get()
        .then(
          (DocumentSnapshot doc) => customerName = doc['fullname'],
        );
    return customerName;
  }

  // get vendor store name
  Future<String> getVendorName(String vendorId) async {
    String storeName = '';
    await FirebaseFirestore.instance
        .collection('vendors')
        .doc(vendorId)
        .get()
        .then(
          (DocumentSnapshot doc) => storeName = doc['storeName'],
        );
    return storeName;
  }

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

              return DataTable(
                showBottomBorder: true,
                headingRowColor:
                    MaterialStateColor.resolveWith((states) => primaryColor),
                headingTextStyle: const TextStyle(color: Colors.white),
                dataRowHeight: 60,
                columns: const [
                  DataColumn(label: Text('Customer Name')),
                  DataColumn(label: Text('Vendor Name')),
                  DataColumn(label: Text('Product Image')),
                  DataColumn(label: Text('Price')),
                  DataColumn(label: Text('Quantity')),
                  DataColumn(label: Text('Product Size')),
                  DataColumn(label: Text('Action')),
                  DataColumn(label: Text('Action')),
                ],
                rows: snapshot.data!.docs
                    .map(
                      (item) => DataRow(
                        cells: [
                          DataCell(Text(
                              getCustomerName(item['customerId']) as String)),
                          DataCell(
                              Text(getVendorName(item['vendorId']) as String)),
                          DataCell(
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item['prodImg'],
                                width: 50,
                              ),
                            ),
                          ),
                          DataCell(Text('\$${item['prodPrice']}')),
                          DataCell(Text('${item['quantity']}')),
                          DataCell(Text('${item['prodSize']}')),
                          DataCell(
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: item['isApproved']
                                      ? accentColor
                                      : primaryColor),
                              onPressed: () => toggleApproval(
                                item['prodId'],
                                item['isApproved'],
                              ),
                              child: Text(
                                item['isApproved'] ? 'Reject' : 'Approve',
                              ),
                            ),
                          ),
                          DataCell(
                            ElevatedButton(
                              onPressed: () => deleteOrder(item['orderId']),
                              child: const Text('Delete'),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              );
            },
          )
        ],
      ),
    );
  }
}
