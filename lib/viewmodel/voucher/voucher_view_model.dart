import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../../model/voucher.dart';

class VoucherViewModel {

  CollectionReference<Map<String, dynamic>>  voucherRef  = FirebaseFirestore.instance.collection("vouchers");

  Future<String> insertVoucher(Voucher voucher) async => voucherRef.add(voucher.toMap())
      .then((value) => Future.value(value.id))
      .catchError((error) => Future.value(error.toString()));

  Future<void> updateVoucher(Voucher voucher){
    //update voucher to database
    
    return Future.delayed(const Duration(seconds: 1));
  }

  Future<void> deleteVoucher(Voucher voucher){
    //delete voucher from database
    return Future.delayed(const Duration(seconds: 1));
  }

  Future<void> getVoucher(){
    //get voucher from database
    return Future.delayed(const Duration(seconds: 1));
  }

  Future<void> getVoucherById(String id){
    //get voucher by id from database
    return Future.delayed(const Duration(seconds: 1));
  }
}