import 'package:blog/core/routers.dart';
import 'package:blog/domain/post/post.dart';
import 'package:blog/main.dart';
import 'package:blog/provider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homePageViewModel = StateNotifierProvider<HomePageViewModel, List<Post>>((ref) {
  AuthProvider ap = ref.read(authProvider);
  return HomePageViewModel([], ap)..initViewModel();
});

class HomePageViewModel extends StateNotifier<List<Post>> {
  // 홈페이지에 진입했을때 열리게 됨
  AuthProvider ap;
  HomePageViewModel(super.state, this.ap);

  void initViewModel() {
    // 비지니스 로직 필요함

    if (ap.isLogin) {
      // repository 접근해서, 값 받아와서 state에 저장
    } else {
      // 페이지 이동
      Navigator.popAndPushNamed(navigatorKey.currentContext!, Routers.loginForm);
    }
  }
}
