import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony/Database/api_service.dart';
import 'package:matrimony/Database/db_helper.dart';
import 'package:matrimony/SCREEN/add_user.dart';
import 'package:matrimony/SCREEN/profile.dart';

import '../Database/user.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  bool isAscending = true;
  ApiService apiService = ApiService();

  Future<List<Map<String, dynamic>>> fetchFavoriteUsers() async {
    List<User> users = await apiService.getAllUser(context);
    return users
        .where((user) => user.IS_FAV == "true")
        .map((user) => user.toMap()) // Convert each user to Map<String, dynamic>
        .toList();
  }

  void sortUser(List<Map<String, dynamic>> users) {
    users.sort((a, b) {
      int comparison = a["firstname"].compareTo(b["lastname"]);
      return isAscending ? comparison : -comparison;
    });
  }

  void toggleFavorite(User user) async {
    try {
      String newFavStatus = user.IS_FAV == "true" ? "false" : "true";
      user.IS_FAV = newFavStatus;

      await apiService.updateUser(user, context);

      setState(() {
        // Refresh the user list to reflect the new favorite status
        fetchFavoriteUsers();
      });
    } catch (error) {
      print("Error updating favorite status: $error");
    }
  }

  void deleteUser(String id) async {
    try {
      await apiService.deleteUser(id, context);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User deleted successfully!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting user: $error'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void showDeleteConfirmation(String id) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Delete User', style: TextStyle(fontFamily: 'Poppins')),
          content: Text('Are you sure you want to delete this user?'),
          actions: [
            CupertinoDialogAction(
              child: Text('Delete', style: TextStyle(fontFamily: 'Poppins')),
              onPressed: () {
                deleteUser(id);
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text('Cancel', style: TextStyle(fontFamily: 'Poppins')),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sort by"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Sort A → Z"),
                leading: Icon(Icons.sort_by_alpha),
                onTap: () {
                  setState(() {
                    isAscending = true;
                  });
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              ListTile(
                title: Text("Sort Z → A"),
                leading: Icon(Icons.sort),
                onTap: () {
                  setState(() {
                    isAscending = false;
                  });
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Users"),
        actions: [
          IconButton(
            icon: Icon(
              isAscending ? Icons.sort_by_alpha : Icons.sort,
            ),
            onPressed: () {
              _showSortDialog(context);
            },
            tooltip: isAscending ? "Sort A → Z" : "Sort Z → A",
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                labelText: "Search by Name, City, or Age",
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => setState(() {
                    _searchController.clear();
                    _searchQuery = '';
                  }),
                )
                    : null,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchFavoriteUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No favourite users found'));
                } else {
                  List<Map<String, dynamic>> filteredUsers =
                  snapshot.data!.where((user) {
                    String query = _searchQuery.toLowerCase();

                    bool matchesName = user["firstname"]
                        .toString()
                        .toLowerCase()
                        .contains(query) ||
                        user["lastname"]
                            .toString()
                            .toLowerCase()
                            .contains(query);
                    bool matchesCity = user["city"] != null &&
                        user["city"].toString().toLowerCase().contains(query);
                    bool matchesAge = user["age"] != null &&
                        user["age"].toString().contains(query);

                    return matchesName || matchesCity || matchesAge;
                  }).toList();

                  sortUser(filteredUsers);

                  return ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      var user = filteredUsers[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.orange),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                  child: Text(
                                    user["firstname"][0].toUpperCase(),
                                  ),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    "${user["firstname"]} ${user["lastname"]}",
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    Icon(
                                      Icons.email_outlined,
                                      color: Colors.deepOrange,
                                      size: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        user["occupation"],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () =>
                                          toggleFavorite(User.toUser(user)),
                                      icon: Icon(
                                        user['IS_FAV'] == "true"
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                    ),
                                    PopupMenuButton<String>(
                                      icon: Icon(Icons.more_vert),
                                      onSelected: (value) async {
                                        if (value == 'Edit') {
                                          final updatedUser =
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddUser(userData: user),
                                            ),
                                          );

                                          if (updatedUser != null) {
                                            setState(() {
                                              fetchFavoriteUsers();
                                            });
                                          }
                                        } else if (value == 'Delete') {
                                          showDeleteConfirmation(user['id']);
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 'Edit',
                                          child: Row(
                                            children: [
                                              Icon(Icons.edit,
                                                  color: Colors.blue),
                                              SizedBox(width: 10),
                                              Text('Edit'),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 'Delete',
                                          child: Row(
                                            children: [
                                              Icon(Icons.delete,
                                                  color: Colors.red),
                                              SizedBox(width: 10),
                                              Text('Delete'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Profile(userData: user),
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                ),
                                child: Divider(
                                  height: 30,
                                  thickness: 2,
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 13),
                                  Icon(Icons.location_on,
                                      color: Colors.deepOrange),
                                  Expanded(
                                    child: Text(
                                      user['city'],
                                      style: TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.phone, color: Colors.green),
                                  SizedBox(width: 5),
                                  Text("+91 " + user['MobileNumber']),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                    ),
                                    child: Divider(
                                      height: 30,
                                      thickness: 2,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  SizedBox(width: 13),
                                  Icon(Icons.email, color: Colors.pink),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      user['email'],
                                      style: TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}