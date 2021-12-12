import 'package:flutter/material.dart';
import 'package:mycompany/src/config/themes/app_colors.dart';

class MainButton extends StatefulWidget {
  const MainButton(
      {Key? key, required this.title, required this.onPressed, this.centerIcon})
      : super(key: key);

  final String title;
  final VoidCallback? onPressed;
  final IconData? centerIcon;

  @override
  _MainButtonState createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.25),
                spreadRadius: -5,
                blurRadius: 10,
                offset: const Offset(0, 15),
              )
            ]),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.white,
                ),
              ),
              widget.centerIcon != null
                  ? const SizedBox(
                      width: 20,
                    )
                  : Container(),
              widget.centerIcon != null
                  ? Icon(
                      widget.centerIcon,
                      color: AppColors.white,
                      size: 26,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
