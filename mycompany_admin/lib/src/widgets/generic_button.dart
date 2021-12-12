import 'package:flutter/material.dart';
import 'package:mycompany_admin/theme/app_colors.dart';

class GenericButton extends StatefulWidget {
  const GenericButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.centerIcon,
      required this.backColor,
      required this.fontColor,
      required this.shadowColor,
      this.borderColor,
      this.radius})
      : super(key: key);

  final String title;
  final VoidCallback? onPressed;
  final IconData? centerIcon;
  final Color backColor;
  final Color fontColor;
  final Color shadowColor;
  final Color? borderColor;
  final double? radius;

  @override
  _GenericButtonState createState() => _GenericButtonState();
}

class _GenericButtonState extends State<GenericButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: widget.backColor,
            border: Border.all(
                width: 1, color: widget.borderColor ?? AppColors.transparent),
            borderRadius: BorderRadius.all(
              Radius.circular(widget.radius ?? 10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: widget.shadowColor.withOpacity(0.25),
                spreadRadius: -5,
                blurRadius: 10,
                offset: const Offset(0, 15),
              )
            ]),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: widget.fontColor,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              widget.centerIcon != null
                  ? Icon(
                      widget.centerIcon,
                      color: widget.fontColor,
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
