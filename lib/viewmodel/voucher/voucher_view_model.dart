import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../../model/uservoucher.dart';
import '../../model/voucher.dart';

class VoucherViewModel {

  CollectionReference<Map<String, dynamic>>  voucherRef  = FirebaseFirestore.instance.collection("vouchers");

  Future<String> insertVoucher(Voucher voucher) async => voucherRef.add(voucher.toMap())
      .then((value) => Future.value(value.id))
      .catchError((error) => Future.value(error.toString()));

  Future<String> updateVoucher(Voucher voucher) async => voucherRef.add(voucher.toMap())
        .then((value) => Future.value("Update Successfilly"))
        .catchError((error) => Future.value(error.toString()));

  Future<void> deleteVoucher(String id) async => voucherRef.doc(id).delete()
      .then((value) => Future.value("Delete Successfilly"))
      .catchError((error) => Future.value(error.toString()));

  Future<void> get getVoucher async => voucherRef.get().then((value) => value.docs.forEach((element) {
      Logger().i(element.data());
    }));

  Future<Voucher> getVoucherById(String id)=> voucherRef.doc(id).get().then((value) => Future.value(Voucher.fromMap(value.data()!)));
}