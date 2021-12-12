import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany/src/blocs/login/login_bloc.dart';
import 'package:mycompany/src/blocs/register/register_bloc.dart';
import 'package:mycompany/src/presentation/screens/login.dart';
import 'package:mycompany/src/presentation/shared/widgets/dismiss_keyboard.dart';
import 'package:mycompany/src/presentation/widgets/auth_header.dart';
import 'package:mycompany/src/presentation/widgets/auth_rich_text.dart';
import 'package:mycompany/src/presentation/widgets/classic_text_input.dart';
import 'package:mycompany/src/presentation/widgets/fingerprint_button.dart';
import 'package:mycompany/src/presentation/widgets/main_button.dart';
import 'package:mycompany/src/presentation/widgets/scaffold_snack_bar.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _firstNameTextController =
      TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();

  bool _firstNameError = false;
  bool _lastNameError = false;

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

  void onRegisterButtonPressed(BuildContext context) {
    if (isFirstNameValid() || isLastNameValid()) {
      BlocProvider.of<RegisterBloc>(context)
          .emit(const RegisterError("One or more fields are empty"));
    } else {
      BlocProvider.of<RegisterBloc>(context).add(RegisterSubmitEvent(
          _firstNameTextController.text,
          _lastNameTextController.text,
          _emailTextController.text,
          _passwordTextController.text));
    }
  }

  void onRichTextTap(BuildContext context) {
    Navigator.pop(context, MaterialPageRoute(builder: (context) {
      return BlocProvider(
          create: (context) => LoginBloc(), child: const LoginScreen());
    }));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: DismissKeyboard(
        child: Scaffold(
          body: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterError ||
                  isLastNameValid() ||
                  isFirstNameValid()) {
                scaffoldSnackBar(context, state);
              }
            },
            builder: (context, state) {
              if (state is RegisterLoaded) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  Navigator.pushNamed(context, '/welcome');
                });
              }
              return _buildInitialPage(state);
            },
          ),
        ),
      ),
    );
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
                              keyboardType: TextInputType.name,
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
                              keyboardType: TextInputType.name,
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
                                    textController: _passwordTextController,
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
                        child: state is RegisterLoading
                            ? _buildLoading()
                            : Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30, top: 10),
                        child: Column(
                          children: [
                            MainButton(
                                title: "Create account",
                                onPressed: () =>
                                    onRegisterButtonPressed(context)),
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
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }
}
