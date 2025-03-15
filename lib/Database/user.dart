class User {
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? MobileNumber;
  String? occupation;
  String? dob;
  String? city;
  String? gender;
  String? hobbies; // Made optional
  String? password;
  String? IS_FAV;


  User({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.MobileNumber,
    this.occupation,
    this.dob,
    this.city,
    this.gender,
    this.hobbies, // Made optional
    this.password,
    this.IS_FAV = "false",
  });

  static User toUser(Map<String, dynamic> u) {
    return User(
      id: u["id"]?.toString() ?? "",
      firstname: u["firstname"]?.toString() ?? "",
      lastname: u["lastname"]?.toString() ?? "",
      email: u["email"]?.toString() ?? "",
      MobileNumber: u["MobileNumber"]?.toString() ?? "",
      occupation: u["occupation"]?.toString() ?? "",
      dob: u["dob"]?.toString() ?? "",
      city: u["city"]?.toString() ?? "",
      gender: u["gender"]?.toString() ?? "",
      hobbies: u["hobbies"]?.toString() ?? "", // Handle null value
      password: u["password"]?.toString() ?? "",
      IS_FAV: u["IS_FAV"]?.toString() ?? "false"
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id ?? "",
      "firstname": firstname ?? "",
      "lastname": lastname ?? "",
      "email": email ?? "",
      "MobileNumber": MobileNumber ?? "",
      "occupation": occupation ?? "",
      "dob": dob ?? "",
      "city": city ?? "",
      "gender": gender ?? "",
      "hobbies": hobbies ?? "",
      "password": password ?? "",
      "IS_FAV" : IS_FAV ?? "false",
    };
  }
}