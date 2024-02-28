import 'package:flutter/material.dart';
import 'package:planpal_frontend/widgets/scaffolds/headers/homepageheader.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePageHeader(),
      body: const Center(
        child: Text('홈 페이지'),
      ),
    );
  }
}
