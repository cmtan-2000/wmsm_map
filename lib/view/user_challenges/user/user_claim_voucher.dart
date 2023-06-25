import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_outlinedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/horizontal_voucher.dart';

class UserClaimVoucher extends StatefulWidget {
  const UserClaimVoucher({super.key});

  @override
  State<UserClaimVoucher> createState() => _UserClaimVoucherState();
}

class _UserClaimVoucherState extends State<UserClaimVoucher> {
  @override
  Widget build(BuildContext context) {
    bool isNotClaimed = true;

    return Scaffold(
        body: Container(
      color: Theme.of(context).primaryColor,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            title: Text('Claim Voucher',
                style: Theme.of(context).textTheme.bodyLarge),
            automaticallyImplyLeading: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                //*one voucher
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Card(
                    elevation: 2,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: HorizontalCoupon(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CustomOutlinedButton(
                                  //TODO: After claim, change to true
                                  disabled: false,
                                  iconData: LineAwesomeIcons.wallet,
                                  //set onPressed to null when already press once
                                  onPressed: () {
                                    Logger().i('isNotClaimed: $isNotClaimed');
                                  },
                                  text: 'Claim Voucher',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
