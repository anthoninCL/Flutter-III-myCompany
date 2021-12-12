import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany/src/blocs/login/login_bloc.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';
import 'package:mycompany/src/presentation/shared/widgets/dismiss_keyboard.dart';
import 'package:mycompany/src/presentation/widgets/auth_header.dart';
import 'package:mycompany/src/presentation/widgets/auth_rich_text.dart';
import 'package:mycompany/src/presentation/widgets/classic_text_input.dart';
import 'package:mycompany/src/presentation/widgets/fingerprint_button.dart';
import 'package:mycompany/src/presentation/widgets/main_button.dart';
import 'package:mycompany/src/presentation/widgets/scaffold_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  void onRichTextTap(BuildContext context) {
    Navigator.pushNamed(context, "/register");
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: DismissKeyboard(
        child: Scaffold(
          body: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginError) {
                scaffoldSnackBar(context, state);
              }
            },
            builder: (context, state) {
              if (state is LoginLoaded) {
                Navigator.pushNamed(context, "/");
              }
              return _buildInitialPage(state);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildInitialPage(state) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
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
                                controller: _emailTextController,
                                placeholder: "Email"),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ClassicTextInput(
                                    controller: _emailTextController,
                                    placeholder: "Password",
                                    secure: true,
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
                        child: state is LoginLoading
                            ? _buildLoading()
                            : Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30, top: 10),
                        child: Column(
                          children: [
                            MainButton(
                                title: "Login",
                                onPressed: () => login(context)),
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
    );
  }

  void login(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(LoginSubmitEvent(
        _emailTextController.text, _passwordTextController.text));
  }
}
