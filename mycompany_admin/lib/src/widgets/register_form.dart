import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany_admin/src/blocs/register/register_bloc.dart';
import 'package:mycompany_admin/src/screens/login_screen.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mycompany_admin/src/widgets/classic_text_input.dart';
import 'package:mycompany_admin/src/widgets/generic_button.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

import 'auth_header.dart';
import 'auth_rich_text.dart';

const List<Color> colors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
];

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _firstnameTextController =
      TextEditingController();
  final TextEditingController _lastnameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _companyNameTextController =
      TextEditingController();
  final TextEditingController _companyAddressTextController =
      TextEditingController();
  final TextEditingController _companyZipcodeTextController =
      TextEditingController();
  final TextEditingController _companyCityTextController =
      TextEditingController();
  final TextEditingController _companyCountryTextController =
      TextEditingController();
  final TextEditingController _companyEmailTextController =
      TextEditingController();
  final TextEditingController _companyPhoneTextController =
      TextEditingController();
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  late int _stepIndex = 0;

  bool _emailError = false;
  bool _passwordError = false;
  bool _companyEmailError = false;

  @override
  void initState() {
    super.initState();
    _emailError = false;
    _passwordError = false;
    _companyEmailError = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
      if (state is RegisterError) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text('Error'),
                  content: Text(state.error),
                  actions: [
                    ElevatedButton(
                      child: Text('Got it'),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ]);
            });
      }
    }, builder: (context, state) {
      if (state is RegisterLoaded) {
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          Navigator.pushNamed(context, LoginScreen.id);
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
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 30, left: 20, right: 20),
                  child: AuthHeader(
                    title: _stepIndex == 0
                        ? "Create a new account"
                        : "Create a company",
                    subtitle: _stepIndex == 0
                        ? "Create an account in order to manage your personal company"
                        : "Enter the information of your company",
                    spaceBetween: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Stepper(
                      type: StepperType.horizontal,
                      currentStep: _stepIndex,
                      steps: stepList(),
                      onStepContinue: () {
                        if (_stepIndex < (stepList().length - 1)) {
                          if (_stepIndex == 0) {
                            setState(() {
                              _stepIndex += 1;
                            });
                          } else {
                            setState(() {
                              _stepIndex += 1;
                            });
                          }
                        } else {
                          register(context);
                        }
                      },
                      onStepCancel: () {
                        if (_stepIndex == 0) {
                          return;
                        }
                        setState(() {
                          _stepIndex -= 1;
                        });
                      },
                      onStepTapped: (int index) {
                        setState(() {
                          _stepIndex = index;
                        });
                      },
                      controlsBuilder: (context,
                          {onStepContinue, onStepCancel}) {
                        final isLastStep = _stepIndex == stepList().length - 1;
                        return Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (_stepIndex > 0)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: GenericButton(
                                    title: "Back",
                                    onPressed: onStepCancel,
                                    backColor: AppColors.white,
                                    fontColor: AppColors.primary,
                                    shadowColor: AppColors.primary,
                                    borderColor: AppColors.primary,
                                  ),
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: GenericButton(
                                  title: isLastStep ? "Submit" : "Continue",
                                  onPressed: onStepContinue,
                                  backColor: AppColors.primary,
                                  fontColor: AppColors.white,
                                  shadowColor: AppColors.primary,
                                  borderColor: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Center(
                    child: AuthRichText(
                      content: "Already have an account? ",
                      richContent: "Sign in",
                      onTap: () => Navigator.pushNamed(context, LoginScreen.id),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      );
    });
  }

  void register(BuildContext context) {
    BlocProvider.of<RegisterBloc>(context).add(RegisterSubmitEvent(
        _firstnameTextController.text,
        _lastnameTextController.text,
        _emailTextController.text,
        _passwordTextController.text,
        _companyNameTextController.text,
        _companyAddressTextController.text,
        _companyZipcodeTextController.text,
        _companyCityTextController.text,
        _companyCountryTextController.text,
        _companyEmailTextController.text,
        _companyPhoneTextController.text));
  }

  List<Step> stepList() => [
        Step(
            state: _stepIndex <= 0 ? StepState.editing : StepState.complete,
            isActive: _stepIndex >= 0,
            title: const Text("Account"),
            content: _accountStep()),
        Step(
            state: _stepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _stepIndex >= 1,
            title: const Text("Company"),
            content: _companyStep()),
        Step(
            state: _stepIndex <= 2 ? StepState.editing : StepState.complete,
            isActive: _stepIndex >= 2,
            title: const Text("Address"),
            content: _companyInfoStep()),
        Step(
            state: _stepIndex <= 3 ? StepState.editing : StepState.complete,
            isActive: _stepIndex >= 3,
            title: const Text("Contact"),
            content: _companyContactStep()),
      ];

  Widget _accountStep() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ClassicTextInput(
              hintText: "Firstname",
              isSecured: false,
              height: 60,
              borderRadius: 10,
              hasBorder: false,
              color: AppColors.whiteDark,
              keyboardType: TextInputType.emailAddress,
              textController: _firstnameTextController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ClassicTextInput(
              hintText: "Lastname",
              isSecured: false,
              textController: _lastnameTextController,
              height: 60,
              borderRadius: 10,
              hasBorder: false,
              color: AppColors.whiteDark,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ClassicTextInput(
              hintText: "Email",
              isSecured: false,
              height: 60,
              borderRadius: 10,
              hasBorder: false,
              color: AppColors.whiteDark,
              keyboardType: TextInputType.emailAddress,
              textController: _emailTextController,
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
        ],
      );

  Widget _companyStep() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ClassicTextInput(
              hintText: "Company name",
              isSecured: false,
              height: 60,
              borderRadius: 10,
              hasBorder: false,
              color: AppColors.whiteDark,
              keyboardType: TextInputType.emailAddress,
              textController: _companyNameTextController,
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Select a color'),
                        content: SingleChildScrollView(
                          child: BlockPicker(
                            onColorChanged: changeColor,
                            pickerColor: currentColor,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Row(children: [
                  Container(
                    width: 60,
                    height: 40,
                    decoration: BoxDecoration(
                      color: pickerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Select the color of your company',
                    style: TextStyle(color: AppColors.darkLight, fontSize: 14),
                  )
                ]),
              ))
        ],
      );

  Widget _companyInfoStep() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ClassicTextInput(
              hintText: "Address",
              isSecured: false,
              height: 60,
              borderRadius: 10,
              hasBorder: false,
              color: AppColors.whiteDark,
              keyboardType: TextInputType.emailAddress,
              textController: _companyAddressTextController,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150,
                child: ClassicTextInput(
                  hintText: "Zip code",
                  isSecured: false,
                  height: 60,
                  borderRadius: 10,
                  hasBorder: false,
                  color: AppColors.whiteDark,
                  keyboardType: TextInputType.emailAddress,
                  textController: _companyZipcodeTextController,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: ClassicTextInput(
                  hintText: "City",
                  isSecured: false,
                  height: 60,
                  borderRadius: 10,
                  hasBorder: false,
                  color: AppColors.whiteDark,
                  keyboardType: TextInputType.emailAddress,
                  textController: _companyCityTextController,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ClassicTextInput(
              hintText: "Country",
              isSecured: false,
              height: 60,
              borderRadius: 10,
              hasBorder: false,
              color: AppColors.whiteDark,
              keyboardType: TextInputType.emailAddress,
              textController: _companyCountryTextController,
            ),
          ),
        ],
      );

  Widget _companyContactStep() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ClassicTextInput(
              hintText: "Company email",
              isSecured: false,
              height: 60,
              borderRadius: 10,
              hasBorder: false,
              color: AppColors.whiteDark,
              keyboardType: TextInputType.emailAddress,
              textController: _companyEmailTextController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ClassicTextInput(
              hintText: "Company phone nuber",
              isSecured: false,
              height: 60,
              borderRadius: 10,
              hasBorder: false,
              color: AppColors.whiteDark,
              keyboardType: TextInputType.emailAddress,
              textController: _companyPhoneTextController,
            ),
          ),
        ],
      );
}
