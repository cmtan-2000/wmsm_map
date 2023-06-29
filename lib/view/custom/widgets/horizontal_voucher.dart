import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';


import '../../../model/uservoucher.dart';
import '../../../model/voucher.dart';

class HorizontalCoupon extends StatelessWidget {
  const HorizontalCoupon({Key? key, required this.voucher, required this.userVoucherId}) : super(key: key);

  // final NewChallenge voucherList;
  final UserVoucher voucher;
  final String userVoucherId;


  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    DateFormat dateFormat = DateFormat('dd MMM yyyy');
    String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }


  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color.fromARGB(255, 220, 233, 193);
    const Color secondaryColor = Color.fromARGB(255, 20, 97, 55);

    const Color usedColor = Color.fromARGB(255, 230, 230, 230);
    const Color expiredColor = Color.fromARGB(255, 213, 213, 213);

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("vouchers").doc(voucher.vid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        Voucher v = Voucher.fromMap(snapshot.data!.data()!);
        Logger().wtf(v.name);
        Logger().wtf(userVoucherId);
        String date = formatDate(v.expirationDate);
        return GestureDetector(
          onTap: () {
            // Logger().wtf(voucherList.newChallengeVoucher);
            voucher.status == "Available" 
            ? showDialog(
                context: context,
                barrierColor: Colors.white.withOpacity(0.95),
                builder: ((context) {
                  return Dialog(child: CouponBarcode(userVoucherId: userVoucherId, couponName: v.name, couponDiscount: "RM ${v.price}" ));
                }))
            : null;
          },
          child: CouponCard(
            height: 150,
            backgroundColor:  voucher.status != "Expired"
                  ? voucher.status == "Available"
                      ? primaryColor
                      : usedColor
                  : usedColor,
            curveAxis: Axis.vertical,
            firstChild: Container(
              decoration: BoxDecoration(
                color: voucher.status != "Expired" ? voucher.status=="Available" ? secondaryColor: expiredColor : expiredColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'RM ${v.price}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
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
                        'Walk More\nSave More',
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
                children: [
                  const Text(
                    'Coupon Code',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    v.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(voucher.status == "Available" ? "Use this coupon to get RM ${v.price} off your next purchase" : "This coupon has been used or expired", style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                  ),),
                  const Spacer(),
                  Text(
                    'Valid Till - $date',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

class CouponBarcode extends StatelessWidget {
  const CouponBarcode({Key? key, required this.userVoucherId, required this.couponName, required this.couponDiscount}) : super(key: key);

  final String userVoucherId;
  final String couponName;
  final String couponDiscount;

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
          data: userVoucherId,
          color: Colors.white,
          width: 30,
          height: 30,
        ),
      ),
      secondChild:
          Column(mainAxisAlignment: MainAxisAlignment.center, children:  [
        Text(couponName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 10),
        Text(couponDiscount,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ))
      ]),
    );
  }
}
