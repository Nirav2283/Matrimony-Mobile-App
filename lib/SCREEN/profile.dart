import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  final Map<String, dynamic> userData;

  Profile({required this.userData});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool ishide = true;

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

  // Function to calculate age from birthdate
  int calculateAge(String dob) {
    DateTime? birthDate = parseDate(dob);
    if (birthDate == null) return 0;

    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  @override
  Widget build(BuildContext context) {
    print("User Data in Profile: ${widget.userData}");
    int age = calculateAge(widget.userData['dob']);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Center(
                        child: Text(
                          "${widget.userData['firstname']} ${widget.userData['lastname']}",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.email_outlined, color: Colors.orange),
                          SizedBox(width: 10),
                          Text(
                            "${widget.userData['email']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 20),
                      Row(
                        children: [
                          Icon(Icons.phone_outlined, color: Colors.orange),
                          SizedBox(width: 10),
                          Text(
                            "+91 ${widget.userData['MobileNumber']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 20),
                      Row(
                        children: [
                          Icon(Icons.date_range_outlined, color: Colors.orange),
                          SizedBox(width: 10),
                          Text(
                            "${formatDate(widget.userData['dob'])} (Age: $age)", // Display calculated age
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 20),
                      Row(
                        children: [
                          Icon(
                            widget.userData['gender'] == 'Male' ? Icons.male : Icons.female,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "${widget.userData['gender']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 20),
                      Row(
                        children: [
                          Icon(Icons.favorite_outline, color: Colors.orange),
                          SizedBox(width: 10),
                          Text(
                            "Akhand Single",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 20),
                      Row(
                        children: [
                          Icon(Icons.location_city_outlined, color: Colors.orange),
                          SizedBox(width: 10),
                          Text(
                            "${widget.userData['city']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 20),
                      Row(
                        children: [
                          Icon(Icons.sports_cricket_outlined, color: Colors.orange),
                          SizedBox(width: 10),
                          Text(
                            "${widget.userData['hobbies']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 20),
                      Row(
                        children: [
                          Icon(Icons.school_outlined, color: Colors.orange),
                          SizedBox(width: 10),
                          Text(
                            "${widget.userData['occupation']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 20),
                      Row(
                        children: [
                          Icon(Icons.password_outlined, color: Colors.orange),
                          SizedBox(width: 10),
                          Text(
                            ishide
                                ? "*" * widget.userData['password'].length // Show stars based on password length
                                : widget.userData['password'], // Show actual password
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              ishide ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: Colors.orange,
                            ),
                            onPressed: () {
                              setState(() {
                                ishide = !ishide;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CircleAvatar(
                radius: 45, // Adjust the size
                backgroundColor: Colors.red,
                child: Text(
                  widget.userData['firstname'][0],
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}