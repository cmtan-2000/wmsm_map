class User {
  final String fullname;
  final String username;
  final String password;
  final String email;
  final String phoneNumber;
  final String dateOfBirth;
  //*put null cuz user might not initialise both height and weight at creation of account
  final double? weight; //*in kg
  final double? height; //*in cm
  final String? gender; //* for bmi
  final double? bmi; //* for bmi

  User(
      {required this.fullname,
      required this.username,
      required this.password,
      required this.email,
      required this.phoneNumber,
      required this.dateOfBirth,
      this.weight,
      this.height,
      this.gender,
      this.bmi});
}
