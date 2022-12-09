/*
*  View -> Controller 요청
*  Controller -> Repository 요청
*  Repository -> 스프링서버 요청
*  Controller -> ViewModel 응답
* 
*  Controller 책임 :
*       - View 요청 받고,
*       - Repository에게 통신 요청하고,
*       - 비지니스 로직 처리(페이지 이동, 알림창, ViewModel에 데이터 담기)
*  Repository 책임 : 통신하고, 파싱하기
*  ViewModel 책임 : 데이터 담기
* */

class UserController {}
