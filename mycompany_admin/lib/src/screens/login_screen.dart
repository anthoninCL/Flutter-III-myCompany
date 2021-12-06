import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/login_form.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const id = "/login";

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    GlobalKey _loginCardKey = GlobalKey();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: width / 2,
            child: Center(
              child: Image.asset(
                "assets/images/test.png",
                width: MediaQuery.of(context).size.width * 0.95,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          key: _loginCardKey,
          width: width / 2.5,
          height: height,
          child: const Card(
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0)),
            ),
            elevation: 40,
            color: AppColors.background,
            shadowColor: AppColors.grey,
            child: LoginForm(),
          ),
        ),
      ]),
    );
  }
}
