import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/user.dart';
import 'package:project_midterms/data/user_data.dart'; // Import dummyUsers
import 'package:project_midterms/data/transaction_data.dart'; // Import dummyTransaksi
import 'package:project_midterms/models/transaksi.dart'; // Import Transaksi model

class ScanQrPage extends StatefulWidget {
  final UserModel user;
  const ScanQrPage({super.key, required this.user});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
  );

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) async { // Made async to await dialog
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      final String? rawValue = barcode.rawValue;
      if (rawValue != null) {
        cameraController.stop(); // Stop scanning after first detection
        int? pointsChange = int.tryParse(rawValue);

        if (pointsChange != null && pointsChange != 0) {
          final userIndex = dummyUsers.indexWhere((u) => u.id == widget.user.id);
          if (userIndex != -1) {
            if (pointsChange < 0 && dummyUsers[userIndex].poin < pointsChange.abs()) {
              if (!mounted) return;
              await _showResultDialog("Not enough points!", "You do not have enough points to redeem ${pointsChange.abs()} points.", Icons.error, Colors.red);
              if (!mounted) return;
              Navigator.pop(context);
              break;
            }

            String transactionTitle = "";
            String dialogTitle = "";
            String dialogMessage = "";
            IconData dialogIcon = Icons.info;
            Color dialogColor = Colors.blue;

            setState(() {
              dummyUsers[userIndex].poin += pointsChange;
              widget.user.poin = dummyUsers[userIndex].poin;

              if (pointsChange > 0) {
                transactionTitle = "QR Scan Points Added";
                dialogTitle = "Points Added!";
                dialogMessage = "Successfully added $pointsChange points! Total points: ${dummyUsers[userIndex].poin}";
                dialogIcon = Icons.check_circle;
                dialogColor = Colors.green;
              } else {
                transactionTitle = "QR Scan Points Redeemed";
                dialogTitle = "Points Redeemed!";
                dialogMessage = "Successfully redeemed ${pointsChange.abs()} points! Total points: ${dummyUsers[userIndex].poin}";
                dialogIcon = Icons.remove_circle;
                dialogColor = Colors.orange;
              }

              dummyTransaksi.insert(
                0,
                Transaksi(
                  title: transactionTitle,
                  amount: 0,
                  pointsChange: pointsChange,
                  date: DateTime.now(),
                ),
              );
            });
            if (!mounted) return;
            await _showResultDialog(dialogTitle, dialogMessage, dialogIcon, dialogColor);
          } else {
            if (!mounted) return;
            await _showResultDialog("Error", "User not found in global list.", Icons.error, Colors.red);
          }
        } else {
          if (!mounted) return;
          await _showResultDialog("Invalid QR Code", "Could not parse points or points are zero.", Icons.warning, Colors.orange);
        }
        if (!mounted) return;
        // Navigator.pop(context); // Go back to previous screen (HomePage) - Removed to prevent double pop
        break;
      }
    }
  }

  Future<void> _showResultDialog(String title, String message, IconData icon, Color color) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Row(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(width: 10),
              Expanded(child: Text(title, style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold))),
            ],
          ),
          content: Text(message, style: TextStyle(color: AppColors.white.withAlpha(200))),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss dialog
                Navigator.pop(context); // Go back to previous screen (HomePage)
              },
              child: Text("OK", style: TextStyle(color: AppColors.gold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR"), backgroundColor: AppColors.black,),
      body: MobileScanner(
        controller: cameraController,
        onDetect: _onDetect,
      ),
    );
  }
}
