class SignupModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String country;
  final String city;
  final String address;

  const SignupModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.country,
      required this.city,
      required this.address});
}
