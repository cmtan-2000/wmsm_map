import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../../model/uservoucher.dart';

class UserVoucherViewModel{
    CollectionReference<Map<String, dynamic>> userVoucherRef =
      FirebaseFirestore.instance.collection("uservouchers");


Future<String> inserUserVoucher(UserVoucher userVoucher) async =>
      userVoucherRef
          .add(userVoucher.toMap())
          .then((value) => Future.value(value.id))
          .catchError((error) => Future.value(error.toString()));

// Future<List<String>> getUserVoucher(String uid) async => 
//       userVoucherRef
//           .where("uid", isEqualTo: uid)
//           .get()
//           .then((value){
//             // Logger().w(uid);
//             Logger().w(value.docs);
//             List<String> listVoucher = [];
//             value.docs.forEach((element) {
//               listVoucher.add(element.data()["vid"]);
//             });
//             return Future.value(listVoucher);
//           })
//           .catchError((error) => Future.value(error.toString()));

Future<List<UserVoucher>> getUserVoucher(String uid) async => 
      userVoucherRef
        .where("uid", isEqualTo: uid)
        .get()
        .then((value) => value.docs.map((e){
          var id = e.id;
          UserVoucher uc = UserVoucher(
            id: id,
            uid: e.data()["uid"],
            vid: e.data()["vid"],
            status: e.data()["status"],
          );
          return uc;
        }).toList())
        .catchError((error) => Future.value(error.toString()));


Future<void> updateUserVoucher(String id, String status) async => 
      userVoucherRef
          .doc(id)
          .update({"status": status})
          .then((value) => Future.value("Update Successfully"))
          .catchError((error) => Future.value(error.toString()));
}