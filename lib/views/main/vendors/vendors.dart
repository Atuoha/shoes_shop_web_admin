import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_shop_admin/views/widgets/are_you_sure_dialog.dart';

import '../../../constants/color.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../widgets/loading_widget.dart';

class VendorsScreen extends StatefulWidget {
  const VendorsScreen({Key? key}) : super(key: key);

  @override
  State<VendorsScreen> createState() => _VendorsScreenState();
}

class _VendorsScreenState extends State<VendorsScreen> {
  final Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection('vendors').snapshots();

  // toggle approval
  Future<void> toggleApproval(String docId, bool value) async {
    await FirebaseFirestore.instance.collection('vendors').doc(docId).update(
      {'isApproved': !value},
    );
  }

  deleteStoreDialog(String docId, String storeName) {
    areYouSureDialog(
      title: 'Delete $storeName',
      content: 'Are you sure you want to delete store?',
      context: context,
      action: deleteStore,
      id: docId,
      isIdInvolved: true,
    );
  }

  // delete store
  Future<void> deleteStore(String docId) async {
    await FirebaseFirestore.instance.collection('vendors').doc(docId).delete();
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
          StreamBuilder<QuerySnapshot>(
            stream: stream,
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
                  DataColumn(
                    label: Text('Name'),
                  ),
                  DataColumn(label: Text('Image')),
                  DataColumn(label: Text('City')),
                  DataColumn(label: Text('State')),
                  DataColumn(label: Text('Country')),
                  DataColumn(label: Text('Email Address')),
                  DataColumn(label: Text('Action')),
                  DataColumn(label: Text('Action')),
                ],
                rows: snapshot.data!.docs
                    .map(
                      (vendor) => DataRow(
                        cells: [
                          DataCell(Text(vendor['storeName'])),
                          DataCell(
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                vendor['storeImgUrl'],
                                width: 50,
                              ),
                            ),
                          ),
                          DataCell(Text(vendor['city'])),
                          DataCell(Text(vendor['state'])),
                          DataCell(Text(vendor['country'])),
                          DataCell(Text(vendor['email'])),
                          DataCell(
                            ElevatedButton(
                              onPressed: () => toggleApproval(
                                  vendor['storeId'], vendor['isApproved']),
                              child: Text(
                                  vendor['isApproved'] ? 'Reject' : 'Approve'),
                            ),
                          ),
                          DataCell(
                            ElevatedButton(
                              onPressed: () =>
                                  deleteStoreDialog(vendor['storeId'],vendor['storeName']),
                              child: const Text('Delete'),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
