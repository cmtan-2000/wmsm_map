import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../../model/uservoucher.dart';
import '../../model/voucher.dart';

class VoucherViewModel {
  CollectionReference<Map<String, dynamic>> voucherRef =
      FirebaseFirestore.instance.collection("vouchers");
  CollectionReference<Map<String, dynamic>> userVoucherRef =
      FirebaseFirestore.instance.collection("uservouchers");
  CollectionReference<Map<String, dynamic>> challengeRef =
      FirebaseFirestore.instance.collection("challenges");

  Future<String> insertVoucher(Voucher voucher) async => voucherRef
      .add(voucher.toMap())
      .then((value) => Future.value(value.id))
      .catchError((error) => Future.value(error.toString()));

  Future<String> updateVoucher(String vid) async => voucherRef
      .doc(vid)
      .update({"quantity": FieldValue.increment(-1)})
      .then((value) => Future.value(vid))
      .catchError((error) => Future.value(error.toString()));

  Future<void> deleteVoucher(String id) async => voucherRef
      .doc(id)
      .delete()
      .then((value) => Future.value("Delete Successfilly"))
      .catchError((error) => Future.value(error.toString()));

  Future<void> get getVoucher async =>
      voucherRef.get().then((value) => value.docs.forEach((element) {
            Logger().i(element.data());
          }));

  Future<Voucher> getVoucherById(String id) => voucherRef
      .doc(id)
      .get()
      .then((value) => Future.value(Voucher.fromMap(value.data()!)));

  // Used when the voucher still available
  Future<bool> checkQuantityVouchers(List<String> vid) async {
    bool check = true;
    for (int i = 0; i < vid.length; i++) {
      Voucher voucher = await getVoucherById(vid[i]);
      if (voucher.quantity == "0") {
        check = false;
        break;
      }
    }
    return check;
  }

  // bool checkChallengesQuantityVoucher(String cid){
  //   bool check = false;
  //   challengeRef.doc(cid).get().then((value) =>
  //     value.data()!["voucher"].forEach((element) {
  //       Logger().w(element);
  //       getVoucherById(element).then((value){
  //         Logger().wtf(value.quantity);
  //         var test = int.parse(value.quantity);
  //         //var test = "0";
  //         Logger().w(test);
  //         if(test != 0) {
  //           check = true;
  //         } else {
  //           check = false;
  //         }
  //       });
  //       Logger().w(check);
  //     })
  //   );
  //   return check;
  // }

  Future<bool> checkChallengesQuantityVoucher(String cid) async {
    bool check = false;
    final value = await challengeRef.doc(cid).get();
    final vouchers = value.data()!["voucher"];

    for (final element in vouchers) {
      if (check == true) {
        break;
      } else {
        // Logger().w(element);
        final voucher = await getVoucherById(element);
        // Logger().wtf(voucher.quantity);
        final test = voucher.quantity;
        // var test = "0";
        // Logger().w(test);
        if (test != 0) {
          check = true;
        } else {
          check = false;
        }
      }
    }
    return check;
  }

  // Define the Voucher id that available
  Future<String> getAvailableVoucher(List<String> vid) async {
    String voucherId = "";
    for (int i = 0; i < vid.length; i++) {
      if (voucherId != "") {
        break;
      }
      Voucher voucher = await getVoucherById(vid[i]);
      Logger().w(voucher.quantity);
      if (voucher.quantity != "0") {
        voucherId = vid[i];
      }
    }
    if (voucherId == "") {
      return "No voucher available";
    }
    return voucherId;
  }

  Future<bool> checkVoucher(String uid, List<String> vid) async =>
      userVoucherRef.get().then((value){
        bool check = false;
        value.docs.forEach((element) {
          if(element.data()["uid"] == uid && vid.contains(element.data()["vid"])){
            check = true;
          }
        });
        return check;
      });

  // Future<String> insertUserVoucher(UserVoucher userVoucher) async =>
  //     userVoucherRef
  //         .add(userVoucher.toMap())
  //         .then((value) => Future.value(value.id))
  //         .catchError((error) => Future.value(error.toString()));


  Future<String> insertUserVoucher(String vid) async {
    UserVoucher userVoucher = UserVoucher(
      id: "",
      uid: FirebaseAuth.instance.currentUser!.uid,
      vid: vid,
      status: "Available",
    );

    userVoucherRef
        .add(userVoucher.toMap())
        .then((value) => Future.value(vid))
        .catchError((error) => Future.value(error.toString()));
    return vid;
  }
      

  // Find challenge voucherid by id and get voucher id
  Future<List<String>> getVoucherIdByChallengeId(String id) async =>
      challengeRef.doc(id).get().then((value) {
        Logger().w(value.data()!["voucher"]);
        return List<String>.from(value.data()!["voucher"]);
      });
}
