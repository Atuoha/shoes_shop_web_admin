import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_shop_admin/models/product.dart';
import 'package:shoes_shop_admin/resources/assets_manager.dart';

import '../../../constants/color.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../components/scroll_component.dart';
import '../../widgets/loading_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _verticalScrollController = ScrollController();
  final _horizontalScrollController = ScrollController();

  // stream
  Stream<QuerySnapshot> productStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  // toggle Product Approval
  Future<void> toggleApproval(String id, bool status) async {
    await FirebaseFirestore.instance.collection('products').doc(id).update(
      {
        'isApproved': !status,
      },
    );
  }

  // delete Product
  Future<void> deleteProduct(String id) async {
    await FirebaseFirestore.instance.collection('products').doc(id).delete();
  }

  // navigate to single product
  void navigateToSingleProduct(dynamic item) {
    Product product = Product(
      prodId: item['prodId'],
      vendorId: item['vendorId'],
      productName: item['productName'],
      price: double.parse(item['price'].toString()),
      quantity: item['quantity'],
      category: item['category'],
      description: item['description'],
      scheduleDate: item['scheduleDate'].toDate(),
      isCharging: item['isCharging'],
      billingAmount: double.parse(item['billingAmount'].toString()),
      brandName: item['brandName'],
      sizesAvailable: item['sizesAvailable'],
      imgUrls: item['imgUrls'],
      uploadDate: item['uploadDate'].toDate(),
    );
    // navigate to single product
    Navigator.of(context).pushNamed('');
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
          StreamBuilder<QuerySnapshot>(
            stream: productStream,
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
                verticalScrollController: _verticalScrollController,
                horizontalScrollController: _horizontalScrollController,
                child: DataTable(
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
                    DataColumn(label: Text('Action')),
                    DataColumn(label: Text('View')),
                  ],
                  rows: snapshot.data!.docs
                      .map(
                        (item) => DataRow(
                          cells: [
                            DataCell(Text(item['productName'])),
                            DataCell(
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  item['imgUrls'][0],
                                  width: 50,
                                ),
                              ),
                            ),
                            DataCell(Text('\$${item['price']}')),
                            DataCell(
                              Text(
                                item['quantity'].toString(),
                              ),
                            ),
                            DataCell(
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: item['isApproved'] ? accentColor: primaryColor
                                ),
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
                                onPressed: () => deleteProduct(item['prodId']),
                                child: const Text('Delete'),
                              ),
                            ),
                            DataCell(
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: accentColor,
                                ),
                                onPressed: () => navigateToSingleProduct(item),
                                child: const Text('View Product'),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
