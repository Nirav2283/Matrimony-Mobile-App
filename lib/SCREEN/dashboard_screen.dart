import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony/SCREEN/about_us.dart';
import 'package:matrimony/SCREEN/add_user.dart';
import 'package:matrimony/SCREEN/favourites.dart';
import 'package:matrimony/SCREEN/login_page.dart';
import 'package:matrimony/SCREEN/userlist.dart';
import '../variable.dart';
import 'package:matrimony/SCREEN/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Dashboard",
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 30,
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // First Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AddUser()));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 30.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logos/add_user.png',
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "Add User",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Userlist()));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 30.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logos/user_list.png',
                            // Update this asset path if needed
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "User List",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // Second Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>Favourites()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 23.0, vertical: 30.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logos/favourites.png',
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "Favourites",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AboutUs()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 30.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logos/about_us.png',
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "About Us",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(
                  "Nirav Vaghasia",
                  style: TextStyle(fontFamily: 'Poppins' , color: Colors.black),
                ),
                accountEmail: Text(
                  "23010101286 - B.Tech CSE-4",
                  style: TextStyle(fontFamily: 'Poppins' , color: Colors.black),
                ),
                currentAccountPicture: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutUs()));
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/Nirav.jpg'),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent
                ),
            ),
            ListTile(
              title: Text(
                "Add User",
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              leading: Icon(
                Icons.person_add_alt,
                color: Colors.blue,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => (AddUser()),
                ));
              },
            ),
            ListTile(
              title: Text(
                "User List",
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              leading: Icon(
                Icons.list_outlined,
                color: Colors.orange,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => (Userlist()),
                ));
              },
            ),
            ListTile(
              title: Text(
                "Favourites",
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              leading: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => (Favourites()),
                ));
              },
            ),
            ListTile(
              title: Text(
                "About Us",
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              leading: Icon(
                Icons.contact_support,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => (AboutUs()),
                ));
              },
            ),

            ListTile(
              title: Text(
                "Log Out",
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              leading: Icon(
                Icons.logout,
                color: Colors.pink,
              ),
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: Text(
                      "Logout",
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                    content: Text(
                      "Are you sure you want to logout?",
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                    actions: [
                      CupertinoDialogAction(
                        child: Text(
                          "Logout",
                          style: TextStyle(fontFamily: 'Poppins' , color: Colors.red),
                        ),
                        onPressed: () async {
                          var sharedPref = await SharedPreferences.getInstance();
                          sharedPref.setBool(SplashScreenState.KEYLOGIN , false);
                          Navigator.pop(context); // Close the dialog first
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
