import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:matrimony/Database/api_service.dart';
import 'package:matrimony/Database/db_helper.dart';
import 'package:matrimony/Database/user.dart';
// import 'package:matrimony/SCREEN/userlist.dart';
import '../variable.dart';

class AddUser extends StatefulWidget {

  final Map<String, dynamic>? userData;
  const AddUser({super.key , this.userData});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  bool isHide = true;
  bool isHide2 = true;
  void initState() {
    DateTime? parseDate(String dateString) {
      try {
        DateFormat dateFormat;
        if (dateString.contains("/")) {
          dateFormat = DateFormat('dd/MM/yyyy');
        } else if (dateString.contains("-")) {
          dateFormat = DateFormat('yyyy-MM-dd');
        } else {
          return null;
        }
        return dateFormat.parse(dateString);
      } catch (e) {
        print("Error parsing date: $e");
        return null;
      }
    }

    String formatDate(String dob) {
      DateTime? parsedDate = parseDate(dob);
      if (parsedDate != null) {
        return DateFormat('dd/MM/yyyy').format(parsedDate);
      } else {
        return 'Invalid Date';
      }
    }
    super.initState();
    DateTime currentDate = DateTime(1991);
    dobcontroller.text = DateFormat('dd/MM/yyyy ').format(currentDate);
    if (widget.userData == null) {
      fnamecontroller.text = '';
      lnamecontroller.text = '';
      emailcontroller.text = '';
      mobilecontroller.text = '';
      occupationController.text = '';
      dobcontroller.text = '01/01/1991';
      selectedCity = null;
      gender = null;
      isSinging = false;
      isReading = false;
      isTimepass = false;
      isCricket = false;
    } else {
      fnamecontroller.text = widget.userData!['firstname'];
      lnamecontroller.text = widget.userData!['lastname'];
      emailcontroller.text = widget.userData!['email'];
      mobilecontroller.text = widget.userData!['MobileNumber'];
      occupationController.text = widget.userData!['occupation'];
      dobcontroller.text = formatDate(widget.userData!['dob']);
      selectedCity = widget.userData!['city'];
      gender = widget.userData!['gender'];
      isSinging = widget.userData!['hobbies'].contains("Singing");
      isReading = widget.userData!['hobbies'].contains("Reading");
      isCricket = widget.userData!['hobbies'].contains("Cricket");
      isTimepass = widget.userData!['hobbies'].contains("Timepass");
      passwordController.text = widget.userData!['password'];
      confirmPasswordController.text = widget.userData!['password'];
    }
  }

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController fnamecontroller = TextEditingController();
  TextEditingController lnamecontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  DateTime date = DateTime.now();
  ApiService apiService = ApiService();

  void resetValues() {
    setState(() {
      passwordController.text = '';
      confirmPasswordController.text = '';
      dobcontroller.text = '01/01/1991 ';
      fnamecontroller.text = '';
      lnamecontroller.text = '';
      mobilecontroller.text = '';
      emailcontroller.text = '';
      occupationController.text = '';
      gender = null;
      isSinging = false;
      isReading = false;
      isTimepass = false;
      isCricket = false;
      selectedCity = null;
    });
  }
  List<String> hobbies = [];
  void hobbylist() {
    hobbies.clear();
    if (isCricket) {
      hobbies.add("Cricket");
    }
    if (isTimepass) {
      hobbies.add("Timepass");
    }
    if (isSinging) {
      hobbies.add("Singing");
    }
    if (isReading) {
      hobbies.add("Reading");
    }
    print("Hobbies: ${hobbies.join(",")}");
  }
  // List<Map<String, dynamic>> _user = [];


  // void adduser() {
  //   setState(() {
  //     hobbylist();
  //     DateTime dob = DateFormat("dd/MM/yyyy").parse(dobcontroller.text);
  //     int age = DateTime.now().year - dob.year;
  //     if (DateTime.now().month < dob.month ||
  //         (DateTime.now().month == dob.month && DateTime.now().day < dob.day)) {
  //       age--;
  //     }
  //     usersList.add({
  //       'First Name': fnamecontroller.text,
  //       'Last Name': lnamecontroller.text,
  //       'Email': emailcontroller.text,
  //       'Phone': mobilecontroller.text,
  //       'Date of Birth': dobcontroller.text,
  //       'City': selectedCity,
  //       'Gender': gender,
  //       'Hobbies': hobbies.join(' , '),
  //       'Password' : passwordController.text,
  //       'Confirm Password' : confirmPasswordController.text,
  //       'isFav' : false,
  //       'Age' : age.toString(),
  //       'Occupation' : occupationController.text,
  //     });
  //
  //     Navigator.of(context).push(
  //       MaterialPageRoute(builder: (context) => Userlist(user: usersList)),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('User added successfully!'),
  //         duration: Duration(seconds: 2),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //     resetValues();
  //   });
  // }

  // Future<void> saveUser() async {
  //   hobbylist();
  //   DateTime dob = DateFormat("dd/MM/yyyy").parse(dobcontroller.text);
  //   int age = DateTime.now().year - dob.year;
  //   if (DateTime.now().month < dob.month ||
  //       (DateTime.now().month == dob.month && DateTime.now().day < dob.day)) {
  //     age--;
  //   }
  //
  //   //FOR DATABASE
  //
  //   // Map<String, dynamic> userData = {
  //   //   DBHelper.COLUMN_FIRST_NAME: fnamecontroller.text,
  //   //   DBHelper.COLUMN_LAST_NAME: lnamecontroller.text,
  //   //   DBHelper.COLUMN_EMAIL: emailcontroller.text,
  //   //   DBHelper.COLUMN_PHONE: mobilecontroller.text,
  //   //   DBHelper.COLUMN_DOB: dobcontroller.text,
  //   //   DBHelper.COLUMN_CITY: selectedCity,
  //   //   DBHelper.COLUMN_GENDER: gender,
  //   //   DBHelper.COLUMN_HOBBIES: hobbies.join(", "),
  //   //   DBHelper.COLUMN_PASSWORD: passwordController.text,
  //   //   DBHelper.COLUMN_CONFIRM_PASSWORD: confirmPasswordController.text,
  //   //   DBHelper.COLUMN_OCCUPATION: occupationController.text,
  //   //   DBHelper.COLUMN_IS_FAV: widget.userData?["isFav"] ?? 0,
  //   //   DBHelper.COLUMN_AGE: age,
  //   // };
  //
  //   //FOR API
  //   // String hobbiesAsString = hobbies.join(", ");
  //
  //   User user = User(id: "123",
  //       fname: fnamecontroller.text,
  //       lname: lnamecontroller.text,
  //       email: emailcontroller.text,
  //       phone: mobilecontroller.text,
  //       occupation: occupationController.text,
  //       dob: dobcontroller.text,
  //       city: selectedCity,
  //       // hobbies: hobbies,
  //       gender: gender,
  //       password: passwordController.text,
  //       // isFav: false,
  //       age: age.toString(),
  //      );
  //
  //   try{
  //     await apiService.addUser(user);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('User Added successfully!'),
  //         duration: Duration(seconds: 2),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //   }catch(e){
  //     print(e);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error adding user: $e'),
  //         duration: Duration(seconds: 2),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  //
  //   // DBHelper dbHelper = DBHelper.getInstance;
  //   // if (widget.userData == null) {
  //   //   await dbHelper.insertUser(userData);
  //   // } else {
  //   //   int id = widget.userData![DBHelper.COLUMN_ID];
  //   //   userData[DBHelper.COLUMN_ID] = id; // Ensure ID is included
  //   //   await dbHelper.updateUser(id, userData);
  //   // }
  //
  //   // Ensure updated user data is returned
  //   // Navigator.of(context).pop(userData);
  // }

  Future<void> saveUser() async {
    hobbylist();

    DateTime dob = DateFormat("dd/MM/yyyy").parse(dobcontroller.text);

    User user = User(
      id: widget.userData?["id"]?.toString(),
      firstname: fnamecontroller.text,
      lastname: lnamecontroller.text,
      email: emailcontroller.text,
      MobileNumber: mobilecontroller.text,
      occupation: occupationController.text,
      dob: DateFormat("yyyy-MM-dd").format(dob),
      city: selectedCity ?? '',
      gender: gender ?? '',
      hobbies: hobbies.join(","),
      password: passwordController.text,
    );

    try {
      if (widget.userData == null) {
        // Add new user
        await apiService.addUser(user , context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User added successfully!'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        await apiService.updateUser(user , context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User updated successfully!'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      }

      Navigator.of(context).pop(user.toMap());
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }





  Widget buildTextField({
    required String labelText,
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    Widget? suffixIcon,
    TextInputAction? textInputAction,
    TextCapitalization? textCapitalization,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLength: maxLength, // Restrict input but hide counter
        validator: validator,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        inputFormatters: inputFormatters,
        style: TextStyle(fontFamily: 'Poppins'),
        decoration: InputDecoration(
          errorStyle: TextStyle(fontFamily: 'Poppins'),
          hintText: hintText,
          labelText: labelText,
          prefixIcon: Icon(icon),
          hintStyle: TextStyle(fontFamily: 'Poppins'),
          labelStyle: TextStyle(fontFamily: 'Poppins'),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixIcon: suffixIcon,
          counterText: '',
        ),
      ),
    );
  }



  Widget buildCheckBox({
    required String title,
    required bool value,
    required Function(bool?) onChanged,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Checkbox(value: value, onChanged: onChanged),
      title: Text(title, style: TextStyle(fontFamily: 'Poppins')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: ModalRoute.of(context)?.isFirst ?? false
              ? Container()
              : IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined),
          ),
          centerTitle: true,
          title: Text(
            widget.userData == null ? 'Add User' : 'Edit User',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 30,
            ),
          ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: buildTextField(
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.name,
                      labelText: "First Name",
                      hintText: "First Name",
                      icon: Icons.person_2_outlined,
                      controller: fnamecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter FirstName";
                        }
                        String pattern = r"^[a-zA-Z\s']{3,50}$";
                        if (!RegExp(pattern).hasMatch(value)) {
                          return "Enter a valid FirstName";
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: buildTextField(
                      textCapitalization: TextCapitalization.sentences,
                      labelText: "Last Name",
                      hintText: "Last Name",
                      icon: Icons.person_2_outlined,
                      controller: lnamecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter LastName";
                        }
                        String pattern = r"^[a-zA-Z\s']{3,50}$";
                        if (!RegExp(pattern).hasMatch(value)) {
                          return "Enter a valid LastName";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              // Email Field
              buildTextField(
                keyboardType: TextInputType.emailAddress,
                labelText: "Email",
                hintText: "Email",
                icon: Icons.email_outlined,
                controller: emailcontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter an Email";
                  }
                  String pattern =
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                  if (!RegExp(pattern).hasMatch(value)) {
                    return "Enter a valid Email";
                  }
                  return null;
                },
              ),

              // Mobile Number Field
              buildTextField(
                labelText: "Mobile Number",
                hintText: "Mobile Number",
                icon: Icons.phone_outlined,
                controller: mobilecontroller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a Mobile Number";
                  }

                  String pattern = r'^\+?[0-9]{10,15}$';
                  if (!RegExp(pattern).hasMatch(value)) {
                    return "Enter a valid Mobile Number";
                  }
                  return null;
                },
              ),

              buildTextField(
                labelText: "Occupation",
                hintText: "Occupation",
                icon: Icons.school_outlined,
                controller: occupationController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a Occupation";
                  }else{
                    return null;
                  }
                },
              ),


              // Date of Birth Field
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Date of Birth must not be empty";
                    }
                    DateTime dob = DateFormat('dd/MM/yyyy').parse(value);
                    int age = DateTime.now().year - dob.year;
                    if (DateTime.now().month < dob.month ||
                        (DateTime.now().month == dob.month &&
                            DateTime.now().day < dob.day)) {
                      age--;
                    }
                    if (age < 21 && gender == 'Male') {
                      return 'You must be at least 21 years old to register.';
                    }
                    if (age < 18 && gender == 'Female') {
                      return 'You must be at least 18 years old to register.';
                    }
                    return null;
                  },
                  controller: dobcontroller,
                  readOnly: true,
                  onTap: () async {
                    DateTime defaultDate = DateTime(1991, 1, 1);
                    DateTime initialDate = defaultDate;

                    DateTime? d = await showDatePicker(
                      context: context,
                      initialDate: initialDate,
                      firstDate: defaultDate,
                      lastDate: DateTime.now(),
                    );

                    if (d != null) {
                      String formattedDate = DateFormat('dd/MM/yyyy').format(d);
                      setState(() {
                        dobcontroller.text = formattedDate;
                        date = d;
                      });
                    }
                  },
                  style: TextStyle(fontFamily: 'Poppins'),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontFamily: 'Poppins'),
                    hintText: "Date of Birth",
                    labelText: "Date of Birth",
                    prefixIcon: Icon(Icons.date_range_outlined),
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

              // City Dropdown
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField<String>(
                  value: selectedCity,
                  items: cities.map((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child:
                          Text(city, style: TextStyle(fontFamily: 'Poppins')),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedCity = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "City",
                    prefixIcon: Icon(Icons.location_city),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Select a city";
                    }
                    return null;
                  },
                ),
              ),

              // Gender Radio Buttons
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Gender",
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 16)),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text("Male",
                                style: TextStyle(fontFamily: 'Poppins')),
                            value: "Male",
                            groupValue: gender,
                            onChanged: (String? value) {
                              setState(() {
                                gender = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text("Female",
                                style: TextStyle(fontFamily: 'Poppins')),
                            value: "Female",
                            groupValue: gender,
                            onChanged: (String? value) {
                              setState(() {
                                gender = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    if (gender == null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Please select your gender.",
                          style: TextStyle(
                              color: Colors.red, fontFamily: 'Poppins'),
                        ),
                      ),
                  ],
                ),
              ),

              // Hobbies Checkboxes
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hobbies",
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 16)),
                    buildCheckBox(
                      title: "Singing",
                      value: isSinging,
                      onChanged: (bool? value) {
                        setState(() {
                          isSinging = value ?? false;
                        });
                      },
                    ),
                    buildCheckBox(
                      title: "Reading",
                      value: isReading,
                      onChanged: (bool? value) {
                        setState(() {
                          isReading = value ?? false;
                        });
                      },
                    ),
                    buildCheckBox(
                      title: "Cricket",
                      value: isCricket,
                      onChanged: (bool? value) {
                        setState(() {
                          isCricket = value ?? false;
                        });
                      },
                    ),
                    buildCheckBox(
                      title: "Timepass",
                      value: isTimepass,
                      onChanged: (bool? value) {
                        setState(() {
                          isTimepass = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password Cannot be empty";
                    }

                    String pattern = r'^(?=.*?[!@#\$&*~]).{8,}$';
                    if (!RegExp(pattern).hasMatch(value)) {
                      return "Password  Must be at least 8 characters\nand at least 1 special character";
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: isHide,
                  style: TextStyle(fontFamily: 'Poppins'),
                  decoration: InputDecoration(
                      errorStyle: TextStyle(fontFamily: 'Poppins'),
                      hintText: "Password",
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintStyle: TextStyle(fontFamily: 'Poppins'),
                      labelStyle: TextStyle(fontFamily: 'Poppins'),
                      suffixIcon: IconButton(
                        icon: Icon(isHide
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        onPressed: () {
                          setState(() {
                            isHide = !isHide;
                          });
                        },
                      )),
                ),
              ),

              // CONFIRM PASSWORD FIELD
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm Password Cannot be empty";
                    }
                    if (value != passwordController.text) {
                      return "Password do not match";
                    }
                  },
                  controller: confirmPasswordController,
                  obscureText: isHide2,
                  style: TextStyle(fontFamily: 'Poppins'),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontFamily: 'Poppins'),
                    hintText: "Confirm Password",
                    labelText: "Confirm Password",
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                      suffixIcon: IconButton(
                        icon: Icon(isHide2
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        onPressed: () {
                          setState(() {
                            isHide2 = !isHide2;
                          });
                        },
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            if (widget.userData == null) {
                              await saveUser();
                            }else{
                              await saveUser();
                            }
                          }
                        },
                        child: Text(widget.userData == null ? 'Add User' : 'Update User'),
                      ),

                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(context: context, builder: (context){
                            return CupertinoAlertDialog(
                              title: Text('Reset?' , style: TextStyle(fontFamily: 'Poppins'),),
                              content: Text('Are you Sure to Want to Reset?'),
                              actions: [
                                TextButton(onPressed: (){
                                  setState(() {
                                    resetValues();
                                  });
                                  Navigator.of(context).pop();
                                }, child: Text('Yes' ,style: TextStyle(fontFamily: 'Poppins'),)),
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: Text('No' ,style: TextStyle(fontFamily: 'Poppins'),))
                              ],
                            );
                          });
                        },
                        child: Text("Reset"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}