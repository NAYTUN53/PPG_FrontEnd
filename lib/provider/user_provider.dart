import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pwar_pwar_gyi_app/model/user.dart';

class UserProvider extends StateNotifier<User?> {
  UserProvider()
      : super(User(
            id: "",
            fullName: '',
            email: '',
            role: '',
            password: '',
            token: ''));

  User? get user => state;

  void signOut() {
    state = null;
  }

  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }
}

final userProvider =
    StateNotifierProvider<UserProvider, User?>((ref) => UserProvider());
