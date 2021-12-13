import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/blocs/auth/auth_bloc.dart';
import 'package:mycompany_admin/src/screens/main_screen.dart';
import 'package:mycompany_admin/src/screens/register_screen.dart';
import 'package:mycompany_admin/src/widgets/classic_text_input.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

import 'auth_header.dart';
import 'auth_rich_text.dart';
import 'main_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
      return const Text('Click');
    }));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, LoginState>(
    listener: (context, state) {
      if (state is LoginError) {
        showDialog(context: context, builder: (BuildContext context) {
          return Text(state.error);
        });
      }
    },
      builder: (context, state) {
    if (state is LoginLoaded) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushNamed(context, MainScreen.id);
      });
    }
    return Form(
      child: Row(children: [
        const SizedBox(
          width: 50,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: AuthHeader(
                    title: "Welcome 👋",
                    subtitle:
                    "We’re glad to see you here. You can continue to login and manage your company"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ClassicTextInput(
                  hintText: "Email",
                  isSecured: false,
                  textController: _emailTextController,
                  height: 60,
                  borderRadius: 10,
                  hasBorder: false,
                  color: AppColors.whiteDark,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ClassicTextInput(
                  hintText: "Password",
                  isSecured: true,
                  textController: _passwordTextController,
                  height: 60,
                  borderRadius: 10,
                  hasBorder: false,
                  color: AppColors.whiteDark,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    MainButton(
                        title: "Login",
                        onPressed: () =>
                        login(context),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: AuthRichText(
                        content: "Don't have an account yet? ",
                        richContent: "Create one",
                        onTap: () =>
                          SchedulerBinding.instance!.addPostFrameCallback((_) {
                            Navigator.pushNamed(context, RegisterScreen.id);
                          }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 50,
        ),
      ]),
    );
      });
  }

  void login(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(LoginSubmitEvent(
        _emailTextController.text, _passwordTextController.text));
  }
}
