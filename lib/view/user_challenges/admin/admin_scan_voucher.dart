import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:logger/logger.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';

class VoucherScanner extends StatefulWidget {
  const VoucherScanner({super.key});

  @override
  State<VoucherScanner> createState() => _VoucherScannerState();
}

class _VoucherScannerState extends State<VoucherScanner> {
  String getResult = '(Scan result will be shown here)';

  Future scanBarcode() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);

      setState(() {
        getResult = scanResult;
      });

      Logger().i('scan result: $scanResult');
    } on PlatformException {
      scanResult = 'Failed to get platform version';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              title: Text('Scan Voucher',
                  style: Theme.of(context).textTheme.bodyLarge),
              automaticallyImplyLeading: true,
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Column(
                          children: [
                            Text(getResult),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomElevatedButton(
                                    onPressed: () {
                                      scanBarcode();
                                    },
                                    child: const Text('Scan voucher'),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
