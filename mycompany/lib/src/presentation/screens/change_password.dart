import 'package:flutter/material.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';
import 'package:mycompany/src/presentation/widgets/classic_text_input.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change password"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
        child: Column(
          children: [
            ClassicTextInput(controller: widget.controller, placeholder: "New password", secure: true,),
            const SizedBox(height: 15,),
            ClassicTextInput(controller: _confirmPasswordController, placeholder: "Confirm password", secure: true,),
            const SizedBox(height: 15,),
            _buildChangePasswordButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildChangePasswordButton() {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            "Change password",
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
