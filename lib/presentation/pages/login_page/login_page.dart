import 'package:flixid_course/data/dummies/dummy_authentication.dart';
import 'package:flixid_course/data/dummies/dummy_user.dart';
import 'package:flixid_course/domain/usecases/login/login.dart';
import 'package:flixid_course/presentation/pages/main_page/main_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Login login = Login(
                authenticationRepository: DummyAuthentication(),
                userRepository: DummayUser());

            login(LoginParams(
                    email: 'delvinwillian28@gmail.com', password: '123456'))
                .then((result) {
              if (result.isSuccess) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MainPage(
                      user: result.resultValue!,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result.errorMessage!),
                  ),
                );
              }
            });
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}