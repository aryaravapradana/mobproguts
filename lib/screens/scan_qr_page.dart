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

  void _onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      final String? rawValue = barcode.rawValue;
      if (rawValue != null) {
        cameraController.stop(); // Stop scanning after first detection
        int? pointsToAdd = int.tryParse(rawValue);

        if (pointsToAdd != null && pointsToAdd != 0) {
          // Find the actual user in the global dummyUsers list and update their points
          final userIndex = dummyUsers.indexWhere((u) => u.id == widget.user.id);
          if (userIndex != -1) {
            // Check for sufficient points if redeeming
            if (pointsToAdd < 0 && dummyUsers[userIndex].poin < pointsToAdd.abs()) {
              _showSnackBar("Not enough points to redeem!", Colors.red);
              Navigator.pop(context);
              break;
            }

            setState(() {
              dummyUsers[userIndex].poin += pointsToAdd;
              // Also update the local widget.user for immediate UI reflection if needed elsewhere
              widget.user.poin = dummyUsers[userIndex].poin;

              String transactionTitle;
              String snackBarMessage;
              Color snackBarColor;

              if (pointsToAdd > 0) {
                transactionTitle = "QR Scan Points Added";
                snackBarMessage = "Successfully added $pointsToAdd points! Total points: ${dummyUsers[userIndex].poin}";
                snackBarColor = Colors.green;
              } else {
                transactionTitle = "QR Scan Points Redeemed";
                snackBarMessage = "Successfully redeemed ${pointsToAdd.abs()} points! Total points: ${dummyUsers[userIndex].poin}";
                snackBarColor = Colors.orange;
              }

              // Add a transaction record
              dummyTransaksi.insert(
                0,
                Transaksi(
                  title: transactionTitle,
                  amount: 0, // No monetary amount for point scan
                  pointsChange: pointsToAdd, // Points added or redeemed
                  date: DateTime.now(),
                ),
              );
              _showSnackBar(snackBarMessage, snackBarColor);
            });
          } else {
            _showSnackBar("Error: User not found in global list.", Colors.red);
          }
        } else {
          _showSnackBar("Invalid QR code: Could not parse points or points are zero.", Colors.red);
        }
        Navigator.pop(context); // Go back to previous screen (HomePage)
        break;
      }
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
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
