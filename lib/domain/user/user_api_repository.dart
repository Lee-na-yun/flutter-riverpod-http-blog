import 'dart:convert';
import 'dart:math';

import 'package:blog/core/http_connector.dart';
import 'package:blog/domain/user/user.dart';
import 'package:blog/dto/auth_req_dto.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/provider/auth_provider.dart';
import 'package:blog/util/response_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

// repository : responseDto로 바꿔서 응답하는것까지만 하면 됨
final userApiRepository = Provider<UserApiRepository>((ref) {
  return UserApiRepository(ref);
}); // read & watch할 때 메모리게 뜨게 됨!

class UserApiRepository {
  // ==> httpConnector에 의존함
  // 다른 서버에도 넣고 싶으면 Api 붙여서 구분하기!

  UserApiRepository(this._ref); // httpConnector와 통신하기 위해 ref 사용
  Ref _ref;

  // 회원가입
  Future<ResponseDto> join(JoinReqDto joinReqDto) async {
    // body 받아서
    String requestBody = jsonEncode(joinReqDto.toJson()); //map을 json으로 encoding해서 user에 담아서 던짐

    // 통신
    Response response = await _ref.read(httpConnector).post("/join", requestBody);

    return ToResponseDto(response); // ResponseDto 응답
  }

  // 로그인
  Future<ResponseDto> login(LoginReqDto loginReqDto) async {
    //1. json변환
    String requestBody = jsonEncode(loginReqDto.toJson()); //map을 json으로 encoding해서 user에 담아서 던짐

    //2. 통신 시작
    Response response = await _ref.read(httpConnector).post("/login", requestBody);

    //3. 토큰 받기
    String jwtToken = response.headers["authorization"].toString();
    Logger().d(jwtToken); //디버그로 토큰 확인
    // token은 디바이스에 파일로 저장해놓아야 재실행때마다 자동으로 찾아서 로그인할 수 있음!

    //4. 토큰을 디바이스에 저장
    final prefs = await SharedPreferences.getInstance(); // token저장하기(await가 붙으면 전역적으로 사용할 수 없어서 메소드를 따로 만들어서 사용해야함)
    prefs.setString("jwtToken", jwtToken); // =jwtToken으로 저장(앱 다시 켰을때 자동로그인되기) ===> 나중에 전역적으로 관리해줘야 함!

    //5. ResponseDto에서 User꺼내기
    ResponseDto responseDto = ToResponseDto(response);

    //6. AuthProvider에 로그인 정보 저장 (상태state는 없음)
    AuthProvider ap = _ref.read(authProvider);
    ap.user = User.fromJson(responseDto.data); // 다이나믹을 fromJson에 넣어서 user 꺼내기
    ap.jwtToken = jwtToken;
    ap.isLogin = true;

    return responseDto; // ResponseDto 응답
  }
}
