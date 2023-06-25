import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/uservoucher.dart';

class UserVoucherViewModel{
    CollectionReference<Map<String, dynamic>> userVoucherRef =
      FirebaseFirestore.instance.collection("userVouchers");


Future<String> inserUserVoucher(UserVoucher userVoucher) async =>
      userVoucherRef
          .add(userVoucher.toMap())
          .then((value) => Future.value(value.id))
          .catchError((error) => Future.value(error.toString()));


}