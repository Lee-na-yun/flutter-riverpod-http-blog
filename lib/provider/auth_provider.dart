import 'package:blog/domain/user/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider = Provider<AuthProvider>((ref) {
  // 새로고침 또는 다른페이지로 이동할때는 StateNotifier를 사용할 필요 없음 -> 새로고침은 provider사용
  return AuthProvider(ref)..initJwtToken();
});

class AuthProvider {
  // 어디에서나 접근할 수 있는 데이터를 만든 것
  AuthProvider(this._ref);
  Ref _ref;
  String? jwtToken;
  bool isLogin = false; //최초값 // logout하면 true됨
  User? user; //user는 여기에 저장해야 함

  Future<void> initJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    final deviceJwtToken = prefs.getString("jwtToken");
    Logger().d("토큰 저장됨?");
    if (deviceJwtToken != null) {
      Logger().d("토큰이 있음");
      Logger().d("${deviceJwtToken}");
      isLogin = true;
      jwtToken = deviceJwtToken;
      // 통신코드로 user 초기화
      // http://ip주소:8080/userData (GET, Header:token)
    }
  }
}
