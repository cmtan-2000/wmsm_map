import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wmsm_flutter/model/uservoucher.dart';
import 'package:wmsm_flutter/view/custom/widgets/horizontal_voucher.dart';
import 'package:wmsm_flutter/viewmodel/voucher/voucher_view_model.dart';

import '../../model/voucher.dart';
import '../../viewmodel/voucher/user_voucher_view_model.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  // final NewChallenge voucher;
  List<UserVoucher> listVoucher = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserVoucher();
  }

  getUserVoucher() async {
    UserVoucherViewModel userVoucherViewModel = UserVoucherViewModel();
    userVoucherViewModel.getUserVoucher(FirebaseAuth.instance.currentUser!.uid).then((value) async {
      // check for each of the voucher expired or not
      for (var element in value) {
        if(element.status == "Available"){
          Voucher v = await VoucherViewModel().getVoucherById(element.vid);
          if(DateTime.now().isAfter(DateTime.parse(v.expirationDate))){
            Logger().wtf("Update Expired");
            userVoucherViewModel.updateUserVoucher(element.id, "Expired");
          }else{
            Logger().wtf("Noneed Update Expired");
          }
        }
      }

      userVoucherViewModel.getUserVoucher(FirebaseAuth.instance.currentUser!.uid).then((value) {
       setState(() {
          // Logger().wtf(value.first.id);
          listVoucher = value;
          // Logger().wtf(listVoucher);
        });
      });
    });
    // Logger().w(listVoucher);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              title: Text('Vouchers',
                  style: Theme.of(context).textTheme.bodyLarge),
              automaticallyImplyLeading: true,
            ),
            SliverToBoxAdapter(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    listVoucher.isNotEmpty ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Card(
                          elevation: 2,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: listVoucher.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: HorizontalCoupon(voucher: listVoucher[index], userVoucherId: listVoucher[index].id,),
                                    );
                                  }))),
                    ) : const CircularProgressIndicator(),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
