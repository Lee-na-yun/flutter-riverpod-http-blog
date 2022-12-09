import 'dart:convert';

import 'package:blog/core/http_connector.dart';
import 'package:blog/dto/auth_req_dto.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/util/response_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

// repository : responseDto로 바꿔서 응답하는것까지만 하면 됨
final userApiRepository = Provider<UserApiRepository>((ref) {
  return UserApiRepository(ref);
}); // read & watch할 때 메모리게 뜨게 됨!

class UserApiRepository {
  // ==> httpConnector에 의존함
  // 다른 서버에도 넣고 싶으면 Api 붙여서 구분하기!

  UserApiRepository(this._ref); // httpConnector와 통신하기 위해 ref 사용
  Ref _ref;

  // body 받아서
  Future<ResponseDto> join(JoinReqDto joinReqDto) async {
    String requestBody = jsonEncode(joinReqDto.toJson()); //map을 json으로 encoding해서 user에 담아서 던짐

    // 통신
    Response response = await _ref.read(httpConnector).post("/join", requestBody);

    return ToResponseDto(response); // ResponseDto 응답
  }
}
