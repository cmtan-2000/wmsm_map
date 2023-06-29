import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:logger/logger.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/horizontal_voucher.dart';
import 'package:wmsm_flutter/viewmodel/voucher/user_voucher_view_model.dart';

import '../../../model/uservoucher.dart';
import '../../custom/widgets/awesome_snackbar.dart';

class VoucherScanner extends StatefulWidget {
  const VoucherScanner({super.key});

  @override
  State<VoucherScanner> createState() => _VoucherScannerState();
}

class _VoucherScannerState extends State<VoucherScanner> {
  String getResult = '(Scan result will be shown here)';
  String voucherId = "";
  late UserVoucher voucher;

  Future scanBarcode() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);

      setState(() {
        getResult = scanResult;
      });
      return scanResult;
      // Logger().i('scan result: $scanResult');
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
                        child: 
                          voucherId == "" 
                          ? Column(
                              children: [
                                Text(getResult),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomElevatedButton(
                                        onPressed: () {
                                          scanBarcode().then((value) => showDialog(context: context, builder: (context) => AlertDialog(
                                            title: const Text("Scan Result"),
                                            content: Text(value),
                                            actions: [
                                              TextButton(onPressed: () => UserVoucherViewModel().updateUserVoucher(value, "Used").then((value){
                                                // show AweSome alert Dialog
                                                final snackbar = Awesome.snackbar("Voucher","Update Status Voucher Successfully",ContentType.success);
                                                ScaffoldMessenger.of(context)
                                                  ..hideCurrentSnackBar()
                                                  ..showSnackBar(snackbar);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                      
                                              }), child: const Text("Used the voucher")),
                                              TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel"))
                                            ],
                                          )));
                                        },
                                        child: const Text('Scan voucher'),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                            : HorizontalCoupon(voucher: voucher, userVoucherId: voucherId),
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
