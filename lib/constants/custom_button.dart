import 'package:flutter/material.dart';

import 'MyColors.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onClick;
  final String buttonText;
  final double height; // Add a parameter for height
  final double width;  // Add a parameter for width
  final Color? buttonColor;
  final Color? borderColor;
  final Color? textColor;
  final bool? showSuffixIcon;
  final IconData? suffixIcon;
  final bool? showPrefixIcon;
  final String? prefixIcon;
  final double borderRadius;
  final double buttonTextSize;
  final FontWeight fontWeight;

  const CustomButton({
    Key? key,
    required this.onClick,
    required this.buttonText,
    this.height = 50, // Default height value
    this.width = 200,
    this.buttonColor,
    this.borderColor,
    this.textColor,
    this.showSuffixIcon = false,
    this.buttonTextSize = 18,
    this.suffixIcon = Icons.arrow_forward,
    this.fontWeight = FontWeight.normal,
    this.prefixIcon = "",
    this.showPrefixIcon = false,
    required this.borderRadius,  // Default width value
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onClick,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            side:  BorderSide(
              width: 1,
              color: widget.borderColor ?? Colors.transparent, // Use the null-aware operator

            )
        ),
        fixedSize: Size(widget.width, widget.height),
        backgroundColor: widget.buttonColor == null ? MyColors.whiteColor : widget.buttonColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: widget.showPrefixIcon == true, // Show the icon if suffixIcon is true
            child: Image.asset(widget.prefixIcon!, width: 20,height: 20),
          ),
          Visibility(
            visible: widget.showPrefixIcon == true, // Show the icon if suffixIcon is true
            child: SizedBox(width: 20),
          ),
          Text(widget.buttonText,
            style: TextStyle(
                fontSize: widget.buttonTextSize,
                fontWeight: widget.fontWeight,

                color: widget.textColor == null ? MyColors.mainYellowColor : widget.textColor
          )),
            Visibility(
              visible: widget.showSuffixIcon == true, // Show the icon if suffixIcon is true
              child: SizedBox(width: 10),
            ),
            Visibility(
            visible: widget.showSuffixIcon == true, // Show the icon if suffixIcon is true
            child: Icon(widget.suffixIcon,color: MyColors.boneWhite,size: 18),
          ),
        ],
      ),
    );
  }
}
