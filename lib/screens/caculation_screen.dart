import 'package:flutter/material.dart';
import 'package:planpal_frontend/widgets/scaffolds/headers/sendmoneypageheader.dart';

class CalculationScreen extends StatelessWidget {
  const CalculationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SendMoneyPageHeader(),
      body: Center(
        child: Text('정산 페이지'),
      ),
    );
  }
}
