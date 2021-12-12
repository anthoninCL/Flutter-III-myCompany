import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycompany/src/blocs/create_company/create_company_bloc.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';
import 'package:mycompany/src/models/company.dart';
import 'package:mycompany/src/presentation/shared/utils/create_material_color.dart';
import 'package:mycompany/src/presentation/shared/widgets/dismiss_keyboard.dart';
import 'package:mycompany/src/presentation/widgets/app_subtitle.dart';
import 'package:mycompany/src/presentation/widgets/classic_text_input.dart';
import 'package:mycompany/src/presentation/widgets/main_button.dart';
import 'package:mycompany/src/presentation/widgets/scaffold_snack_bar.dart';
import 'package:uuid/uuid.dart';

class CreateCompanyScreen extends StatefulWidget {
  const CreateCompanyScreen({Key? key}) : super(key: key);

  @override
  _CreateCompanyScreenState createState() => _CreateCompanyScreenState();
}

class _CreateCompanyScreenState extends State<CreateCompanyScreen> {
  final TextEditingController _companyNameTextController =
      TextEditingController();
  final TextEditingController _companyAddressTextController =
      TextEditingController();
  final TextEditingController _companyZipCodeTextController =
      TextEditingController();
  final TextEditingController _companyCityTextController =
      TextEditingController();
  final TextEditingController _companyCountryTextController =
      TextEditingController();
  final TextEditingController _companyEmailTextController =
      TextEditingController();
  final TextEditingController _companyPhoneNumberTextController =
      TextEditingController();

  bool _companyNameError = false;
  bool _companyAddressError = false;
  bool _companyZipCodeError = false;
  bool _companyCityError = false;
  bool _companyCountryError = false;
  bool _companyEmailError = false;
  bool _companyPhoneNumberError = false;

  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    _companyNameError = false;
    _companyAddressError = false;
    _companyZipCodeError = false;
    _companyCityError = false;
    _companyCountryError = false;
    _companyEmailError = false;
    _companyPhoneNumberError = false;
  }

  bool isInputValid(controller, state) {
    bool validation = controller.text.trim().isNotEmpty;

    setState(() {
      state = !validation;
    });

    return !validation;
  }

  bool get areInputsValid =>
      isInputValid(_companyNameTextController, _companyNameError) ||
      isInputValid(_companyAddressTextController, _companyAddressError) ||
      isInputValid(_companyZipCodeTextController, _companyZipCodeError) ||
      isInputValid(_companyCityTextController, _companyCityError) ||
      isInputValid(_companyCountryTextController, _companyCountryError) ||
      isInputValid(_companyEmailTextController, _companyEmailError) ||
      isInputValid(_companyPhoneNumberTextController, _companyPhoneNumberError);

  void onStepContinue() {
    if (currentStep < 2) {
      setState(() {
        currentStep += 1;
      });
    } else {
      if (areInputsValid) {
        BlocProvider.of<CreateCompanyBloc>(context)
            .emit(const CreateCompanyError("One or more fields are empty"));
      } else {
        BlocProvider.of<CreateCompanyBloc>(context).add(
          CreateCompanySubmitEvent(
            Company(
              const Uuid().v4().toString(),
              _companyNameTextController.text,
              _companyAddressTextController.text,
              _companyZipCodeTextController.text,
              _companyCityTextController.text,
              _companyCountryTextController.text,
              _companyEmailTextController.text,
              _companyPhoneNumberTextController.text,
              [],
              [],
            ),
          ),
        );
      }
    }
  }

  void onStepCancel() {
    if (currentStep > 0) {
      setState(() {
        currentStep -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: DismissKeyboard(
          child: Scaffold(
            body: BlocConsumer<CreateCompanyBloc, CreateCompanyState>(
                listener: (context, state) {
                  if (state is CreateCompanyError || areInputsValid) {
                    scaffoldSnackBar(context, state);
                  }
                },
                builder: (context, state) {
                  if (state is CreateCompanyLoaded) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      Navigator.pushNamed(context, '/');
                    });
                  }
                  return _buildInitialPage(state);
                }),
          ),
        ));
  }

  Widget _buildInitialPage(state) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
              child: Theme(
            data: ThemeData(
              primarySwatch: createMaterialColor(AppColors.primary),
            ),
            child: Stepper(
              controlsBuilder: (BuildContext context,
                  {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
                return Container();
              },
              elevation: 0,
              physics: const ScrollPhysics(),
              type: StepperType.horizontal,
              steps: getSteps(),
              currentStep: currentStep,
              onStepContinue: onStepContinue,
              onStepCancel: onStepCancel,
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(bottom: 60, top: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                currentStep > 0
                    ? TextButton(
                        onPressed: onStepCancel,
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary),
                        ),
                      )
                    : Container(
                        width: 90,
                      ),
                SizedBox(
                  width: 150,
                  child: MainButton(
                    onPressed: onStepContinue,
                    title: "Continue",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
            title: Text(
              "Company",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: currentStep >= 0 ? AppColors.black : AppColors.grey),
            ),
            content: buildFirstStep(),
            isActive: currentStep >= 0),
        Step(
            title: Text(
              "Address",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: currentStep >= 1 ? AppColors.black : AppColors.grey),
            ),
            content: buildSecondStep(),
            isActive: currentStep >= 1),
        Step(
            title: Text(
              "Contact",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: currentStep >= 2 ? AppColors.black : AppColors.grey),
            ),
            content: buildThirdStep(),
            isActive: currentStep >= 2),
      ];

  Widget buildFirstStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSubtitle(
            title:
                "Write the name of your company and choose your company color"),
        const SizedBox(
          height: 20,
        ),
        ClassicTextInput(
          hintText: "Company name",
          isSecured: false,
          textController: _companyNameTextController,
          height: 60,
          borderRadius: 10,
          hasBorder: false,
          color: AppColors.whiteDark,
        ),
      ],
    );
  }

  Widget buildSecondStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSubtitle(
            title: "Fill in the information about the company location"),
        const SizedBox(
          height: 20,
        ),
        ClassicTextInput(
          hintText: "Company address",
          isSecured: false,
          textController: _companyAddressTextController,
          height: 60,
          borderRadius: 10,
          hasBorder: false,
          color: AppColors.whiteDark,
          keyboardType: TextInputType.streetAddress,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: ClassicTextInput(
                hintText: "Zip code",
                isSecured: false,
                textController: _companyZipCodeTextController,
                height: 60,
                borderRadius: 10,
                hasBorder: false,
                color: AppColors.whiteDark,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: ClassicTextInput(
                hintText: "City",
                isSecured: false,
                textController: _companyCityTextController,
                height: 60,
                borderRadius: 10,
                hasBorder: false,
                color: AppColors.whiteDark,
                keyboardType: TextInputType.name,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        ClassicTextInput(
          hintText: "Country",
          isSecured: false,
          textController: _companyCountryTextController,
          height: 60,
          borderRadius: 10,
          hasBorder: false,
          color: AppColors.whiteDark,
          keyboardType: TextInputType.name,
        ),
      ],
    );
  }

  Widget buildThirdStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSubtitle(
            title: "Complete the company creation with the\ncontact part"),
        const SizedBox(
          height: 20,
        ),
        ClassicTextInput(
          hintText: "Company email",
          isSecured: false,
          textController: _companyEmailTextController,
          height: 60,
          borderRadius: 10,
          hasBorder: false,
          color: AppColors.whiteDark,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 15,
        ),
        ClassicTextInput(
          hintText: "Company phone number",
          isSecured: false,
          textController: _companyPhoneNumberTextController,
          height: 60,
          borderRadius: 10,
          hasBorder: false,
          color: AppColors.whiteDark,
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}
