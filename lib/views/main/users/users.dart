import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../components/scroll_component.dart';
import '../../widgets/are_you_sure_dialog.dart';
import '../../widgets/kcool_alert.dart';
import '../../widgets/loading_widget.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  // stream
  Stream<QuerySnapshot> customersStream =
      FirebaseFirestore.instance.collection('customers').snapshots();

  final _verticalScrollController = ScrollController();
  final _horizontalScrollController = ScrollController();

  // called after alert for dismissal
  doneWithAction() {
    Navigator.of(context).pop();
  }

  // return context
  get cxt => context;

  // delete order
  Future<void> deleteCustomer(String id) async {
    //pop out
    doneWithAction();

    await FirebaseFirestore.instance
        .collection('customers')
        .doc(id)
        .delete()
        .whenComplete(() {
      kCoolAlert(
        message: 'You have successfully set the deleted user',
        context: cxt,
        alert: CoolAlertType.success,
        action: doneWithAction,
      );
    });
  }

  // delete dialog
  void deleteDialog(String id) {
    areYouSureDialog(
      title: 'Delete customer',
      content: 'Are you sure you want to delete customer?',
      context: context,
      action: deleteCustomer,
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
              const Icon(Icons.group),
              const SizedBox(width: 10),
              Text(
                'Users',
                style: getMediumStyle(
                  color: Colors.black,
                  fontSize: FontSize.s16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream: customersStream,
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
                  headingRowColor: MaterialStateColor.resolveWith(
                    (states) => primaryColor,
                  ),
                  headingTextStyle: const TextStyle(color: Colors.white),
                  dataRowHeight: 60,
                  columns: const [
                    DataColumn(
                      label: Text('Name'),
                    ),
                    DataColumn(label: Text('Image')),
                    DataColumn(label: Text('Phone')),
                    DataColumn(label: Text('Email Address')),
                    DataColumn(label: Text('Address')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: snapshot.data!.docs
                      .map(
                        (customer) => DataRow(
                          cells: [
                            DataCell(Text(customer['fullname'])),
                            DataCell(
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  customer['image'],
                                  width: 50,
                                ),
                              ),
                            ),
                            DataCell(Text(customer['phone'])),
                            DataCell(Text(customer['email'])),
                            DataCell(Text(customer['address'])),
                            DataCell(
                              ElevatedButton(
                                onPressed: () => deleteDialog(
                                  customer['customerId'],
                                ),
                                child: const Text('Delete'),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
