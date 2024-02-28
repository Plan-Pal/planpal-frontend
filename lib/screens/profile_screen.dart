import 'package:flutter/material.dart';
import 'package:planpal_frontend/widgets/scaffolds/headers/profilepageheader.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ProfilePageHeader(),
      body: Center(
        child: Text('프로필 페이지'),
      ),
    );
  }
}
