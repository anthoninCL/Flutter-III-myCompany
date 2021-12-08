import 'package:flutter/material.dart';
import 'package:mycompany/theme/app_colors.dart';

class ClassicTextInput extends StatefulWidget {
  const ClassicTextInput(
      {Key? key,
      this.prefixIcon,
      this.prefixIconColor = AppColors.primary,
      this.prefixIconSize = 20,
      required this.hintText,
      required this.isSecured,
      required this.textController,
      this.error = false,
      required this.height,
      required this.borderRadius,
      this.borderColor,
      required this.hasBorder,
      required this.color,
      this.alignment = Alignment.center,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final double? prefixIconSize;
  final String hintText;
  final bool isSecured;
  final TextEditingController textController;
  final bool? error;
  final double height;
  final double borderRadius;
  final Color? borderColor;
  final bool hasBorder;
  final Color color;
  final Alignment? alignment;
  final TextInputType? keyboardType;

  @override
  _ClassicTextInputState createState() => _ClassicTextInputState();
}

class _ClassicTextInputState extends State<ClassicTextInput> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      alignment: widget.alignment,
      padding: EdgeInsets.only(left: widget.prefixIcon != null ? 0 : 20),
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: widget.error != null && widget.error!
              ? Border.all(color: AppColors.red)
              : widget.hasBorder
                  ? Border.all(color: widget.borderColor!)
                  : null),
      child: TextField(
        cursorColor: AppColors.black,
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        enableSuggestions: widget.isSecured ? false : true,
        autocorrect: false,
        obscureText: widget.isSecured ? !_passwordVisible : false,
        decoration: InputDecoration(
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: widget.prefixIconColor,
                    size: widget.prefixIconSize,
                  )
                : null,
            border: InputBorder.none,
            suffixIcon: widget.isSecured
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    splashColor: AppColors.transparent,
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.grey,
                    ))
                : null,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: AppColors.grey,
              fontSize: 14,
            )),
      ),
    );
  }
}
