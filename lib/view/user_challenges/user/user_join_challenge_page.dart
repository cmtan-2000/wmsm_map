// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:wmsm_flutter/main.dart';
// import 'package:wmsm_flutter/model/new_challenge.dart';
// import 'package:wmsm_flutter/model/users.dart';
// import 'package:wmsm_flutter/view/user_challenges/join_challenge_details.dart';

// class UserJoinChallengePage extends StatefulWidget {
//   const UserJoinChallengePage({super.key});

//   @override
//   State<UserJoinChallengePage> createState() => _UserJoinChallengePageState();
// }

// class _UserJoinChallengePageState extends State<UserJoinChallengePage> {
//   FirebaseFirestore db = FirebaseFirestore.instance;
//   String dob = '';
//   String email = '';
//   String fullname = '';
//   String phoneNumber = '';
//   String username = '';

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: db
//           .collection("users")
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .get(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           var userData = Users.fromSnapshot(snapshot.data!);

//           Logger().i(snapshot.data!.data());
//           Logger().i(userData.role);
//           return UserJoinChallengePageWidget(user: userData);
//         } else if (snapshot.hasError) {
//           return const Center(
//             child: Text('Error'),
//           );
//         } else {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }
// }

// //* user join challenge
// class UserJoinChallengePageWidget extends StatefulWidget {
//   const UserJoinChallengePageWidget({super.key, required this.user});

//   final Users user;

//   @override
//   State<UserJoinChallengePageWidget> createState() =>
//       _UserJoinChallengePageWidgetState();
// }

// class _UserJoinChallengePageWidgetState
//     extends State<UserJoinChallengePageWidget> {
//   final List<NewChallenge> listOfNewChallenge = [
//     challenge1,
//     challenge2,
//     challenge3
//   ];

//   int voucherCount = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             floating: true,
//             snap: true,
//             title: Text('Join Challenge',
//                 style: Theme.of(context).textTheme.bodyLarge),
//             automaticallyImplyLeading: true,
//           ),
//           SliverToBoxAdapter(
//             child: Container(
//               color: Theme.of(context).primaryColor,
//               height: MediaQuery.of(context).size.height * 0.9,
//               child: Column(
//                 children: [
//                   //!CRUD JOIN CHALLENGE LIST CARD
//                   Expanded(
//                     child: ListView.builder(
//                         padding:
//                             const EdgeInsets.only(top: 10, left: 20, right: 20),
//                         itemCount: listOfNewChallenge.length,
//                         itemBuilder: (context, index) {
//                           if (index >= 0 && index < listOfNewChallenge.length) {
//                             NewChallenge challenge = listOfNewChallenge[index];

//                             //* loop voucher length
//                             int voucherLength =
//                                 challenge.newChallengeVoucher.length;

//                             Logger().i(listOfNewChallenge.length);

//                             return Card(
//                               elevation: 2,
//                               child: ListTile(
//                                 onTap: () {
//                                   MyApp.navigatorKey.currentState!.push(
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           JoinChallengeDetails(
//                                         challengeTitle:
//                                             challenge.newChallengeTitle,
//                                         challengeDesc:
//                                             challenge.newChallengeDesc,
//                                         challengeEventDuration:
//                                             challenge.newChallengeEventDuration,
//                                         challengeImgPath:
//                                             challenge.newChallengeImgPath,

//                                         //*Challenge steps -> int
//                                         challengeSteps: challenge
//                                             .newChallengeSteps
//                                             .toString(),
//                                         challengeVoucher:
//                                             challenge.newChallengeVoucher[
//                                                 voucherCount % voucherLength],

//                                         user: widget.user,
//                                       ),
//                                     ),
//                                   );
//                                 },

//                                 //* image icon for challenge
//                                 leading: CircleAvatar(
//                                   foregroundImage:
//                                       AssetImage(challenge.newChallengeImgPath),
//                                   backgroundColor: Colors.transparent,
//                                   radius: 25,
//                                 ),

//                                 //* title for challenge
//                                 title: Text(challenge.newChallengeTitle),

//                                 //* duration for challenge
//                                 subtitle: Text(
//                                     challenge.newChallengeEventDuration,
//                                     style: const TextStyle(
//                                         fontSize: 10, color: Colors.teal)),

//                                 //!TEST THIS UI
//                                 trailing: const Icon(Icons.arrow_forward_ios),
//                               ),
//                             );
//                           } else {
//                             return Container();
//                           }
//                         }),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
