import 'package:blog/core/routers.dart';
import 'package:blog/view/pages/post/detail_page.dart';
import 'package:blog/view/pages/user/join_page.dart';
import 'package:blog/view/pages/user/login_page.dart';
import 'package:blog/view/pages/post/update_page.dart';
import 'package:blog/view/pages/post/write_page.dart';
import 'package:blog/view/pages/user/user_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'view/pages/post/home_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,

      // 라우트 설계 필요없음. GetX 사용할 예정
      initialRoute: Routers.joinForm,
      routes: {
        Routers.home: (context) => HomePage(),
        Routers.detail: (context) => DetailPage(),
        Routers.updateForm: (context) => UpdatePage(),
        Routers.joinForm: (context) => JoinPage(),
        Routers.loginForm: (context) => LoginPage(),
        Routers.writeForm: (context) => WritePage(),
        Routers.userInfo: (context) => UserInfoPage(),
      },
    );
  }
}
