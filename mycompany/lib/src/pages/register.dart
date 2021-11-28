import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycompany/src/pages/login.dart';
import 'package:mycompany/src/shared/widgets/dismiss_keyboard.dart';
import 'package:mycompany/src/widgets/auth_header.dart';
import 'package:mycompany/src/widgets/auth_rich_text.dart';
import 'package:mycompany/src/widgets/classic_text_input.dart';
import 'package:mycompany/src/widgets/fingerprint_button.dart';
import 'package:mycompany/src/widgets/main_button.dart';
import 'package:mycompany/theme/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _firstNameTextController = TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();

  bool _emailError = false;
  bool _passwordError = false;
  bool _firstNameError = false;
  bool _lastNameError = false;

  @override
  void initState() {
    super.initState();
    _emailError = false;
    _passwordError = false;
    _firstNameError = false;
    _lastNameError = false;
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

  bool isFirstNameValid() {
    bool validation = _firstNameTextController.text.trim().isNotEmpty;

    setState(() {
      _firstNameError = !validation;
    });

    return !validation;
  }

  bool isLastNameValid() {
    bool validation = _lastNameTextController.text.trim().isNotEmpty;

    setState(() {
      _lastNameError = !validation;
    });

    return !validation;
  }

  void onRichTextTap(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const LoginScreen();
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
                                title: "Create a New Account",
                                subtitle:
                                "Create an account in order to manage your personal company"),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Column(
                                children: [
                                  ClassicTextInput(
                                    hintText: "Firstname",
                                    isSecured: false,
                                    textController: _firstNameTextController,
                                    height: 60,
                                    borderRadius: 10,
                                    hasBorder: false,
                                    color: AppColors.whiteDark,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ClassicTextInput(
                                    hintText: "Lastname",
                                    isSecured: false,
                                    textController: _lastNameTextController,
                                    height: 60,
                                    borderRadius: 10,
                                    hasBorder: false,
                                    color: AppColors.whiteDark,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ClassicTextInput(
                                    hintText: "Email",
                                    isSecured: false,
                                    textController: _emailTextController,
                                    height: 60,
                                    borderRadius: 10,
                                    hasBorder: false,
                                    color: AppColors.whiteDark,
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
                                  const MainButton(title: "Create account", onPressed: null),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  AuthRichText(
                                      content: "Already have an account? ",
                                      richContent: "Sign in",
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
