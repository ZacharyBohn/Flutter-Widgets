import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:split/enums/assets.dart';

class AppDropDown extends StatefulWidget {
  final String? initialValue;
  final List<String> items;
  final double? width;
  final double? height;
  final Function(String)? onSelect;
  final double fontSize;
  final String fontFamily;
  final Color fontColor;
  final Color backgroundColor;
  final Color iconColor;
  final Color underlineColor;

  AppDropDown({
    this.initialValue,
    this.items = const [],
    this.width,
    this.height,
    this.onSelect,
    this.fontSize = 15.0,
    this.fontFamily = '',
    this.fontColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
    this.underlineColor = Colors.grey,
  });

  @override
  _AppDropDownState createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  String currentValue = '';

  @override
  void initState() {
    if (widget.initialValue != null) {
      currentValue = widget.initialValue!;
      return;
    }
    if (widget.items.length > 0) {
      currentValue = widget.items.first;
      return;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double iconSize = size.width * 0.025;
    return PopupMenuButton<String>(
      color: widget.backgroundColor,
      child: Container(
        width: widget.width ?? size.width * 0.25,
        height: widget.height ?? size.height * 0.05,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: widget.underlineColor,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.chevronDown,
              color: widget.iconColor,
              width: iconSize,
              height: iconSize,
            ),
            Expanded(
              child: Center(
                child: Text(
                  currentValue,
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    fontFamily: widget.fontFamily,
                    color: widget.fontColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onSelected: (String value) {
        setState(() {
          currentValue = value;
        });
        widget.onSelect?.call(value);
      },
      itemBuilder: (context) {
        return widget.items.map((value) {
          return PopupMenuItem(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                fontSize: widget.fontSize,
                fontFamily: widget.fontFamily,
                color: widget.fontColor,
              ),
            ),
          );
        }).toList();
      },
    );
  }
}
