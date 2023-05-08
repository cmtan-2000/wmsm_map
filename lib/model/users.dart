class Users {
  String fullname;
  String username;
  String email;
  String phoneNumber;
  String dateOfBirth;
  double? weight; //*in kg
  double? height; //*in cm
  String? gender; //* for bmi
  double? bmi; //* for bmi

  Users(
      {required this.fullname,
      required this.username,
      required this.email,
      required this.phoneNumber,
      required this.dateOfBirth,
      this.weight,
      this.height,
      this.gender,
      this.bmi}); 

  Users.fromJson(Map<String, dynamic> json)
    : fullname = json['fullname'],
      username = json['username'],
      email = json['email'],
      phoneNumber = json['phoneNumber'],
      dateOfBirth = json['dateOfBirth'];

  Map<String, dynamic> toJson() => {
    'fullname' : fullname,
    'username' : username,
    'email' : email,
    'phoneNumber' : phoneNumber,
    'dateOfBirth' : dateOfBirth,
  };  
}
