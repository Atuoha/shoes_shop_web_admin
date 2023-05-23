import 'package:flutter/material.dart';

class CashOutScreen extends StatefulWidget {
  const CashOutScreen({Key? key}) : super(key: key);

  @override
  State<CashOutScreen> createState() => _CashOutScreenState();
}

class _CashOutScreenState extends State<CashOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('CashOutScreen')
    );
  }
}
