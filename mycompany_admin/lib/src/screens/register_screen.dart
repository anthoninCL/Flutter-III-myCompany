import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycompany_admin/src/widgets/login_form.dart';
import 'package:mycompany_admin/src/widgets/register_form.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const id = "/register";

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  @override
  Widget build(BuildContext context) {
    GlobalKey _loginCardKey = GlobalKey();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          key: _loginCardKey,
          width: width * 0.45,
          height: height,
          child: const Card(
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0)),
            ),
            elevation: 40,
            color: AppColors.background,
            shadowColor: AppColors.grey,
            child: RegisterForm(),
          ),
        ),
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
      ]),
    );
  }
}
