import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper{
  DBHelper._();
  static final DBHelper getInstance = DBHelper._();
  static final String TABLE_USERS = 'users';

  static final String COLUMN_ID = 'id';
  static final String COLUMN_FIRST_NAME = 'fname';
  static final String COLUMN_LAST_NAME = 'lname';
  static final String COLUMN_EMAIL = 'email';
  static final String COLUMN_PHONE = 'phone';
  static final String COLUMN_OCCUPATION = 'occupation';
  static final String COLUMN_DOB = 'dob';
  static final String COLUMN_CITY = 'city';
  static final String COLUMN_GENDER = 'gender';
  static final String COLUMN_HOBBIES = 'hobbies';
  static final String COLUMN_PASSWORD = 'password';
  static final String COLUMN_CONFIRM_PASSWORD = 'confirm_password';
  static const String COLUMN_IS_FAV = 'IS_FAV';
  static const String COLUMN_AGE = 'age';

  Database? myDb;

  Future<Database> getDB () async {
    if(myDb != null){
      return myDb!;
    }else{
      myDb = await openDB();
      return myDb!;
    }
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path , 'user_database.db');
    return await openDatabase(dbPath , onCreate: (db , version){
      db.execute(
        '''
          CREATE TABLE $TABLE_USERS(
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
            $COLUMN_FIRST_NAME TEXT,
            $COLUMN_LAST_NAME TEXT,
            $COLUMN_EMAIL TEXT,
            $COLUMN_PHONE TEXT,
            $COLUMN_OCCUPATION TEXT,
            $COLUMN_DOB TEXT,
            $COLUMN_CITY TEXT,
            $COLUMN_GENDER TEXT,
            $COLUMN_HOBBIES TEXT,
            $COLUMN_PASSWORD TEXT,
            $COLUMN_CONFIRM_PASSWORD TEXT,
            $COLUMN_IS_FAV INTEGER,
            $COLUMN_AGE INTEGER
          )
        '''
      );
    } , version: 1);

    //QUERIES

  }
  //INSERT A NEW USER
  Future<void> insertUser(Map<String , dynamic> userData) async {
    var db = await getDB();
    await db.insert(TABLE_USERS, userData);
  }

  //GET ALL USER
  Future<List<Map<String , dynamic>>> getUsers() async {
    var db = await getDB();
    return await db.query(TABLE_USERS);
  }

  //UPDATE USER
  Future<void> updateUser(int id , Map<String , dynamic> userData) async {
    var db = await getDB();
    await db.update(TABLE_USERS, userData , where: '$COLUMN_ID = ?'  , whereArgs:[id] , conflictAlgorithm: ConflictAlgorithm.replace,);

  }

  //DELETE USER
  Future<void> deleteUser(int id) async {
    var db = await getDB();
    await db.delete(TABLE_USERS , where: '$COLUMN_ID = ?' , whereArgs: [id]);
  }
}