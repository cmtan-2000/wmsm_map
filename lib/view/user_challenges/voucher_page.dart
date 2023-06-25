import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/custom/widgets/horizontal_voucher.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({super.key});

  // final NewChallenge voucher;

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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Card(
                          elevation: 2,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: 3,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: HorizontalCoupon(),
                                    );
                                  }))),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
