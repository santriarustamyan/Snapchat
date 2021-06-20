// import 'package:flutter_mongodb_realm/database/mongo_document.dart';
// import 'package:flutter_mongodb_realm/flutter_mongo_realm.dart';
// import 'package:flutter_mongodb_realm/mongo_realm_client.dart';
// import 'package:internship0006/model/user.dart';
// import 'package:bson/bson.dart' show ObjectId;

// class UserRepository {
//   UserRepository() {
//     _collection = client.getDatabase("snapchat").getCollection("user");
//   }
//   late MongoCollection _collection;
//   final MongoRealmClient client = MongoRealmClient();

//   // Future<ObjectId> insertUserDB(User _user) async {
//   //   ObjectId id = await _collection.insertOne(MongoDocument({
//   //     "userFirstname": _user.userFirstname,
//   //     "userLastname": _user.userFirstname,
//   //     "userBirthday": _user.userBirthday,
//   //     "username": _user.username,
//   //     "userPassword": _user.userPassword,
//   //     "userEmail": _user.userEmail,
//   //     "userPhoneNumber": _user.userPhoneNumber,
//   //   }));
//   //   return id;
//   // }

//   // Future<bool> checkUsername(User user) async {
//   //   List<MongoDocument> checkUsername;
//   //   if (user.id == null) {
//   //     checkUsername = await _collection.find(filter: {
//   //       "username": user.username,
//   //     });
//   //   } else {
//   //     checkUsername = await _collection.find(filter: {
//   //       "username": user.username,
//   //       "_id": QueryOperator.ne(user.id)
//   //     });
//   //   }

//   //   int quantity = checkUsername.length;

//   //   if (quantity == 0) return false;
//   //   return true;
//   // }

//   // Future<bool> checkEmail(User user) async {
//   //   List<MongoDocument> checkEmail;

//   //   if (user.id == null) {
//   //     checkEmail = await _collection.find(filter: {
//   //       "userEmail": user.userEmail,
//   //     });
//   //   } else {
//   //     checkEmail = await _collection.find(filter: {
//   //       "userEmail": user.userEmail,
//   //       "_id": QueryOperator.ne(user.id)
//   //     });
//   //   }
//   //   int quantity = checkEmail.length;

//   //   if (quantity == 0) return false;
//   //   return true;
//   // }

//   // Future<bool> checkMobilePhone(User user) async {
//   //   List<MongoDocument> checkMobilePhone = [];
//   //   if (user.id == null) {
//   //     checkMobilePhone = await _collection.find(filter: {
//   //       "userPhoneNumber": user.userPhoneNumber,
//   //     });
//   //   } else {
//   //     checkMobilePhone = await _collection.find(filter: {
//   //       "userPhoneNumber": user.userPhoneNumber,
//   //       "_id": QueryOperator.ne(user.id)
//   //     });
//   //   }

//   //   int quantity = checkMobilePhone.length;

//   //   if (quantity == 0) return false;

//   //   return true;
//   // }

//   // Future<List<User>> getUsers() async {
//   //   var docs = await _collection.find();

//   //   List<User> _users = [];
//   //   docs.forEach((element) {
//   //     User _user = new User();
//   //     _user.id = element.get("_id");
//   //     _user.userFirstname = element.get("userFirstname");
//   //     _user.userLastname = element.get("userLastname");
//   //     _user.userBirthday = element.get("userBirthday");
//   //     _user.username = element.get("username");
//   //     _user.userPassword = element.get("userPassword");
//   //     _user.userEmail = element.get("userEmail");
//   //     _user.userPhoneNumber = element.get("userPhoneNumber");
//   //     _users.add(_user);
//   //   });

//   //   return _users;
//   // }

//   // Future<void> updateUsers(String username, User _user) async {
//   //   await _collection.updateMany(
//   //       filter: {
//   //         "username": username,
//   //       },
//   //       update: UpdateOperator.set({
//   //         "userFirstname": _user.userFirstname,
//   //         "userLastname": _user.userLastname,
//   //         "userBirthday": _user.userBirthday,
//   //         "username": _user.username,
//   //         "userPassword": _user.userPassword,
//   //         "userEmail": _user.userEmail,
//   //         "userPhoneNumber": _user.userPhoneNumber,
//   //       }));
//   // }

//   // Future<User?> login(String usernameOrEmail, String password) async {
//   //   List<User> _users = [];
//   //   _users = await getUsers();
//   //   for (User item in _users) {
//   //     if ((item.userEmail == usernameOrEmail ||
//   //             item.username == usernameOrEmail ||
//   //             item.userPhoneNumber == usernameOrEmail) &&
//   //         item.userPassword == password) {
//   //       return item;
//   //     }
//   //   }
//   //   return null;
//   // }
// }
