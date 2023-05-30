import 'package:cloud_firestore/cloud_firestore.dart';

class NewChallenge {
  final String newChallengeTitle;
  final String newChallengeImgPath;
  final String newChallengeEventDuration;
  final String newChallengeDesc;
  final int newChallengeSteps;
  final List<String> newChallengeVoucher;

  NewChallenge({
    required this.newChallengeTitle,
    required this.newChallengeImgPath,
    required this.newChallengeEventDuration,
    required this.newChallengeDesc,
    required this.newChallengeSteps,
    required this.newChallengeVoucher,
  });

  NewChallenge.fromJson(Map<String, dynamic> json)
      : newChallengeTitle = json['newChallengeTitle'],
        newChallengeImgPath = json['newChallengeImgPath'],
        newChallengeEventDuration = json['newChallengeEventDuration'],
        newChallengeDesc = json['newChallengeDesc'],
        newChallengeSteps = json['newChallengeSteps'],
        newChallengeVoucher = json['newChallengeVoucher'];

  Map<String, dynamic> toJson() => {
        'newChallengeTitle': newChallengeTitle,
        'newChallengeImgPath': newChallengeImgPath,
        'newChallengeEventDuration': newChallengeEventDuration,
        'newChallengeDesc': newChallengeDesc,
        'newChallengeSteps': newChallengeSteps,
        'newChallengeVoucher': newChallengeVoucher,
      };

  factory NewChallenge.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return NewChallenge(
      newChallengeTitle: data['newChallengeTitle'],
      newChallengeImgPath: data['newChallengeImgPath'],
      newChallengeEventDuration: data['newChallengeEventDuration'],
      newChallengeDesc: data['newChallengeDesc'],
      newChallengeSteps: data['newChallengeSteps'],
      newChallengeVoucher: data['newChallengeVoucher'],
    );
  }
}

//?dummy data
NewChallenge challenge1 = NewChallenge(
  newChallengeTitle: 'Walk 100 miles',
  newChallengeEventDuration: '10/5/2023-10/6/2023',
  newChallengeImgPath: 'assets/images/challenge1.png',
  newChallengeSteps: 1000,
  newChallengeDesc:
      'The purpose is purpose that purpose is purpose this purpose not purpose some purpose walk purpose the purpose is purpose that purpose is purpose this purpose not purpose some purpose walk purpose.',
  newChallengeVoucher: ['RM3 Tealive Off', 'RM3 FamilyMart Off'],
);

NewChallenge challenge2 = NewChallenge(
  newChallengeTitle: 'Walk for 1 hour everyday',
  newChallengeEventDuration: '10/5/2023-10/6/2023',
  newChallengeImgPath: 'assets/images/challenge2.png',
  newChallengeSteps: 6000,
  newChallengeDesc:
      'The purpose is purpose that purpose is purpose this purpose not purpose some purpose walk purpose the purpose is purpose that purpose is purpose this purpose not purpose some purpose walk purpose.',
  newChallengeVoucher: ['RM5 AEON Off', 'RM2 Petrol Off'],
);

NewChallenge challenge3 = NewChallenge(
  newChallengeTitle: 'Burn 100 calories per day',
  newChallengeEventDuration: '10/5/2023-10/6/2023',
  newChallengeImgPath: 'assets/images/challenge3.png',
  newChallengeSteps: 3000,
  newChallengeDesc:
      'Recent World Health Organization reports and guidelines note that more than 80% of adolescents across the globe have insufficient physical activity per day. Physical inactivity has been associated with several non-communicable diseases in adults such as cardiovascular diseases, type 2 diabetes, and cancer. In the pediatric population, the majority of movement behaviour studies have focused on the effect of sedentary behaviour and physical activity on cardiometabolic health which includes blood pressure, insulin resistance, blood lipids, and body mass index. There has been a gap in knowledge on the effect of sedentary time and moderate-to-vigorous physical activity on cardiac structure and function in large adolescent populations due to the scarcity of device-measured movement behaviour and echocardiography assessment in the pediatric population. A higher left ventricular mass, which indicates an enlarged or hypertrophied heart, and a reduced left ventricular function, which indicates decreased heart function, may in combination or independently lead to an increased risk of heart failure, myocardial infarction, stroke, and premature cardiovascular death.',
  newChallengeVoucher: ['RM5 Chatime Off', 'RM2 Petrol Off'],
);
