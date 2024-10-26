/*import 'package:hive/hive.dart';
import 'user_model.dart';

class HiveService {
  final Box<UserModel> userBox;

  HiveService(this.userBox);

  Future<void> addUser(UserModel user) async {
    await userBox.put(user.username, user); // Use username as the key
  }

  UserModel? getUser(String username) {
    return userBox.get(username);
  }

  bool validateUser(String username, String password) {
    final user = getUser(username);
    return user != null && user.password == password; // Validate credentials
  }
}
*/
