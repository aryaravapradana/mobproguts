import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:project_midterms/colors.dart';
import 'package:project_midterms/models/user.dart';
import 'package:project_midterms/data/user_data.dart';
import 'package:project_midterms/data/transaction_data.dart';
import 'package:project_midterms/models/transaksi.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScanQrPage extends StatefulWidget {
  final UserModel user;
  const ScanQrPage({super.key, required this.user});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  final MobileScannerController cameraController = MobileScannerController();

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
      cameraController.stop();
      final String rawValue = barcodes.first.rawValue!;
      _processQrCode(rawValue);
    }
  }

  void _processQrCode(String rawValue) {
    int? pointsChange = int.tryParse(rawValue);

    if (pointsChange != null && pointsChange != 0) {
      final userIndex = dummyUsers.indexWhere((u) => u.id == widget.user.id);
      if (userIndex != -1) {
        if (pointsChange < 0 && dummyUsers[userIndex].poin < pointsChange.abs()) {
          _showResultDialog("Not Enough Points", "You do not have enough points to redeem ${pointsChange.abs()} points.", FontAwesomeIcons.circleExclamation, AppColors.error);
          return;
        }

        setState(() {
          dummyUsers[userIndex].poin += pointsChange;
          widget.user.poin = dummyUsers[userIndex].poin;

          final transactionTitle = pointsChange > 0 ? "Points Added via QR" : "Points Redeemed via QR";
          dummyTransaksi.insert(0, Transaksi(title: transactionTitle, amount: 0, pointsChange: pointsChange, date: DateTime.now()));
        });

        final dialogTitle = pointsChange > 0 ? "Points Added!" : "Points Redeemed!";
        final dialogMessage = "Successfully ${pointsChange > 0 ? 'added' : 'redeemed'} ${pointsChange.abs()} points. Your new balance is ${dummyUsers[userIndex].poin}.";
        _showResultDialog(dialogTitle, dialogMessage, FontAwesomeIcons.circleCheck, AppColors.success);
      } else {
        _showResultDialog("Error", "User not found.", FontAwesomeIcons.triangleExclamation, AppColors.error);
      }
    } else {
      _showResultDialog("Invalid QR Code", "The scanned QR code is not a valid point value.", FontAwesomeIcons.qrcode, AppColors.warning);
    }
  }

  Future<void> _showResultDialog(String title, String message, IconData icon, Color color) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Row(
            children: [Icon(icon, color: color, size: 24), const SizedBox(width: 12), Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold))],
          ),
          content: Text(message, style: GoogleFonts.poppins()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
                Navigator.of(context).pop(); 
              },
              child: Text("OK", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR Code")),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: _onDetect,
          ),
          _buildScannerOverlay(),
        ],
      ),
    );
  }

  Widget _buildScannerOverlay() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 4),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Point your camera at a QR code',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, backgroundColor: Colors.black54),
          ),
        ],
      ),
    );
  }
}