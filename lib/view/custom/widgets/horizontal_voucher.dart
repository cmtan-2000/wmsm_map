import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:coupon_uikit/coupon_uikit.dart';

class HorizontalCoupon extends StatelessWidget {
  const HorizontalCoupon({Key? key}) : super(key: key);

  // final NewChallenge voucherList;

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color.fromARGB(255, 220, 233, 193);
    const Color secondaryColor = Color.fromARGB(255, 20, 97, 55);

    return GestureDetector(
      onTap: () {
        // Logger().wtf(voucherList.newChallengeVoucher);
        showDialog(
            context: context,
            barrierColor: Colors.white.withOpacity(0.95),
            builder: ((context) {
              return const Dialog(child: CouponBarcode());
            }));
      },
      child: CouponCard(
        height: 150,
        backgroundColor: primaryColor,
        curveAxis: Axis.vertical,
        firstChild: Container(
          decoration: const BoxDecoration(
            color: secondaryColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        '23%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'OFF',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(color: Colors.white54, height: 0),
              const Expanded(
                child: Center(
                  child: Text(
                    'WINTER IS\nHERE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        secondChild: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Coupon Code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'FREESALES',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                'Valid Till - 30 Jan 2022',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CouponBarcode extends StatelessWidget {
  const CouponBarcode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CouponCard(
      height: 300,
      curvePosition: 180,
      curveRadius: 30,
      borderRadius: 10,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 83, 182, 127),
            Color.fromARGB(255, 20, 97, 55),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      firstChild: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(18),
        child: BarcodeWidget(
          barcode: Barcode.qrCode(),
          //TODO: qr code data
          data: 'Khew Jia Peng',
          color: Colors.white,
          width: 30,
          height: 30,
        ),
      ),
      secondChild:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
        Text('TEALIVE VOUCHER',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 10),
        Text('RM3 OFF',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ))
      ]),
    );
  }
}
