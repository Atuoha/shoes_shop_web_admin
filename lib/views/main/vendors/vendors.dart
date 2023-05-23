import 'package:flutter/material.dart';

class VendorsScreen extends StatefulWidget {
  const VendorsScreen({Key? key}) : super(key: key);

  @override
  State<VendorsScreen> createState() => _VendorsScreenState();
}

class _VendorsScreenState extends State<VendorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Vendors')
    );
  }
}
