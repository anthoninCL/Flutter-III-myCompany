import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycompany/src/pages/register.dart';
import 'package:mycompany/src/shared/widgets/dismiss_keyboard.dart';
import 'package:mycompany/src/widgets/auth_header.dart';
import 'package:mycompany/src/widgets/auth_rich_text.dart';
import 'package:mycompany/src/widgets/fingerprint_button.dart';
import 'package:mycompany/src/widgets/main_button.dart';
import 'package:mycompany/src/widgets/classic_text_input.dart';
import 'package:mycompany/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  bool _emailError = false;
  bool _passwordError = false;

  @override
  void initState() {
    super.initState();
    _emailError = false;
    _passwordError = false;
  }

  bool isEmailValid() {
    bool validation = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailTextController.text);

    setState(() {
      _emailError = !validation;
    });

    return !validation;
  }

  bool isPasswordValid() {
    bool validation = _passwordTextController.text.trim().isNotEmpty;

    setState(() {
      _passwordError = !validation;
    });

    return !validation;
  }

  void onRichTextTap(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const RegisterScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: DismissKeyboard(
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraint.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 75,
                            ),
                            const AuthHeader(
                                title: "Welcome 👋",
                                subtitle:
                                    "We’re glad to see you here. You can continue to login and manage your company"),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Column(
                                children: [
                                  ClassicTextInput(
                                    hintText: "Email",
                                    isSecured: false,
                                    textController: _emailTextController,
                                    height: 60,
                                    borderRadius: 10,
                                    hasBorder: false,
                                    color: AppColors.whiteDark,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ClassicTextInput(
                                          hintText: "Password",
                                          isSecured: true,
                                          textController:
                                              _passwordTextController,
                                          height: 60,
                                          borderRadius: 10,
                                          hasBorder: false,
                                          color: AppColors.whiteDark,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const FingerPrintButton(),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Text(
                                          "Forgot password?",
                                          style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30, top: 10),
                              child: Column(
                                children: [
                                  const MainButton(title: "Login", onPressed: null),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  AuthRichText(
                                      content: "Don't have an account yet? ",
                                      richContent: "Create one",
                                      onTap: () => onRichTextTap(context)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
