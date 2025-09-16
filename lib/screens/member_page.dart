import 'package:flutter/material.dart';
import '../models/user.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Info Member')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Nama: ${currentUser.name}"),
            Text("Email: ${currentUser.email}"),
            Text("Level: ${currentUser.level}"),
            Text("Total Spending: Rp${currentUser.spending}"),
          ],
        ),
      ),
    );
  }
}
