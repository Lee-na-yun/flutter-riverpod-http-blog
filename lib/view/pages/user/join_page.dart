import 'package:blog/controller/user_controller.dart';
import 'package:blog/util/validator_util.dart';
import 'package:blog/view/components/custom_elevated_button.dart';
import 'package:blog/view/components/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>(); // formKey로 모든 inpufield를 제어 할 수 있음

  // Form 땡겨쓰기
  final _username = TextEditingController(); // 추가
  final _password = TextEditingController(); // 추가
  final _email = TextEditingController(); // 추가

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uc = ref.read(userController); // read해서 userController 읽기

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 200,
              child: Text(
                "회원가입 페이지",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _joinForm(uc),
          ],
        ),
      ),
    );
  }

  Widget _joinForm(UserController uc) {
    // 실행전에 uc의 타입이 UserController인지 알 수 없기때문에 타입을 적어줘야 함!
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _username,
            hint: "Username",
            funValidator: validateUsername(),
          ),
          CustomTextFormField(
            controller: _password,
            hint: "Password",
            funValidator: validatePassword(),
          ),
          CustomTextFormField(
            controller: _email,
            hint: "Email",
            funValidator: validateEmail(),
          ),
          CustomElevatedButton(
            text: "회원가입",
            funPageRoute: () {
              if (_formKey.currentState!.validate()) {
                uc.join(
                  username: _username.text.trim(),
                  password: _password.text.trim(),
                  email: _email.text.trim(), // trim() : 앞뒤 공백제거
                );
              } // _formKey.currentState!.validate() = 회원가입에 항상 필요함!
            },
          ),
          TextButton(
            onPressed: () {
              uc.loginForm();
            },
            child: Text("로그인 페이지로 이동"),
          ),
        ],
      ),
    );
  }
}
