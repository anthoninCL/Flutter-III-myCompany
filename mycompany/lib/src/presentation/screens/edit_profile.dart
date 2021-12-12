import 'package:flutter/material.dart';
import 'package:mycompany/src/blocs/user/user_bloc.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';
import 'package:mycompany/src/config/themes/card_decoration.dart';
import 'package:mycompany/src/models/user.dart';
import 'package:mycompany/src/presentation/screens/change_password.dart';
import 'package:mycompany/src/presentation/widgets/header_label.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.user}) : super(key: key);

  final UserFront user;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressController;
  late TextEditingController _zipCodeController;
  late TextEditingController _cityController;
  late TextEditingController _countryController;
  late TextEditingController _passwordController;

  final UserBloc _userBloc = UserBloc();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _emailController.text = widget.user.email;
    _phoneNumberController = TextEditingController();
    _phoneNumberController.text = widget.user.phoneNumber;
    _addressController = TextEditingController();
    _addressController.text = widget.user.address;
    _zipCodeController = TextEditingController();
    _zipCodeController.text = widget.user.zipCode;
    _cityController = TextEditingController();
    _cityController.text = widget.user.city;
    _countryController = TextEditingController();
    _countryController.text = widget.user.country;
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _zipCodeController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onTapDone() {
    var user = UserFront(
        widget.user.firstName,
        widget.user.lastName,
        _emailController.text,
        _addressController.text,
        _zipCodeController.text,
        _cityController.text,
        _countryController.text,
        _phoneNumberController.text,
        widget.user.role,
        widget.user.projects,
        widget.user.poles,
        widget.user.companyId);
    _userBloc.add(UpdateUser(user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit profile"),
        actions: [
          GestureDetector(
            onTap: () {
              _onTapDone();
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Center(
                child: Text(
                  "Done",
                  style: TextStyle(fontSize: 16, color: AppColors.primary),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderLabel(label: "Personal information"),
            _buildEmailInput(),
            const SizedBox(
              height: 15,
            ),
            _buildPhoneNumberInput(),
            const SizedBox(
              height: 15,
            ),
            _buildAddressAndZipInputs(),
            const SizedBox(
              height: 15,
            ),
            _buildCityAndCountryInputs(),
            const SizedBox(
              height: 15,
            ),
            //_buildChangePasswordButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: CardDecoration(),
      child: TextField(
        style: TextStyle(fontSize: 14, color: Colors.black),
        controller: _emailController,
        textAlign: TextAlign.end,
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          prefixText: "Email: ",
          prefixStyle: TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: CardDecoration(),
      child: TextField(
        style: TextStyle(fontSize: 14, color: Colors.black),
        controller: _phoneNumberController,
        textAlign: TextAlign.end,
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          prefixText: "Phone number: ",
          prefixStyle: TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildAddressAndZipInputs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 1.55,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: CardDecoration(),
          child: TextField(
            style: TextStyle(fontSize: 14, color: Colors.black),
            controller: _addressController,
            textAlign: TextAlign.end,
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              prefixText: "Address: ",
              prefixStyle: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 4.2,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: CardDecoration(),
          child: TextField(
            style: TextStyle(fontSize: 14, color: Colors.black),
            controller: _zipCodeController,
            textAlign: TextAlign.end,
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              prefixText: "Zip: ",
              prefixStyle: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCityAndCountryInputs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: (MediaQuery.of(context).size.width - 40) / 2.05,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: CardDecoration(),
          child: TextField(
            style: TextStyle(fontSize: 14, color: Colors.black),
            controller: _cityController,
            textAlign: TextAlign.end,
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              prefixText: "City: ",
              prefixStyle: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 40) / 2.05,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: CardDecoration(),
          child: TextField(
            style: TextStyle(fontSize: 14, color: Colors.black),
            controller: _countryController,
            textAlign: TextAlign.end,
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              prefixText: "Country: ",
              prefixStyle: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChangePasswordButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChangePassword(controller: _passwordController),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: CardDecoration(),
        child: const Center(
          child: Text(
            "Change password",
            style: TextStyle(fontSize: 14, color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
