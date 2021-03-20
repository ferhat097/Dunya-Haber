import 'package:flutter/material.dart';
import 'package:haber/Service/login_manager.dart';

import 'loginAndRegPages.dart';

class LoginPage extends StatefulWidget {
   final BuildContext context1;

  const LoginPage({Key key, this.context1}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  PageController pageController = PageController();
  @override
  void dispose() {
    emailController.dispose();
    pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage('assets/background.png'))),
        child: SafeArea(
          child: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Login(
                contextpr: widget.context1,
                pageController: pageController,
              ),
              Register(
                pageController: pageController,
              ),
              Succes(
                contextpr: widget.context1,
                pageController: pageController,
              ),
                            RecoverPass(
                pageController: pageController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

signIn(String text, String text2) async {
  await ApiManager().signIn(text, text2);
}
