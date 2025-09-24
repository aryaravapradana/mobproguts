import 'package:flutter/material.dart';
import '../models/user.dart';

class MemberPage extends StatelessWidget {
  final UserModel user;
  const MemberPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Info Member')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Nama: ${user.name}"),
            Text("Email: ${user.email}"),
            Text("Level: ${user.level}"),
            Text("Total Spending: Rp${user.spending}"),
          ],
        ),
      ),
    );
  }
}