import 'package:flutter/material.dart';

//view model for formBuilder

class FormBuilderModel {
  /// Type of the field
  final String fieldType;

  ///icon image path
  final Icon icon;

  ///field name
  final String name;
//textStyle
  final TextStyle style;

  ///initialValue
  final initialValue;

  //field placeholder
  final String placeholder;

  //fieldOptions
  final Object fieldOptions;

  final List selectOptions;

  final TextEditingController controller;

  //loginStyle
  final loginStyle;

  final onChanged;

  final ValueChanged<String> onSubmitted;

  final onTap;

  final Function valueTransformer;

  final bool requiredField;

  final bool requiredFieldPassword;

  final int minLength;

  final int maxLength;

  final bool hideVisibleButton;

  FormBuilderModel({
    this.icon,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.fieldOptions,
    this.initialValue,
    this.placeholder,
    this.style,
    this.loginStyle = false,
    this.selectOptions,
    this.valueTransformer,
    this.controller,
    this.requiredField = false,
    this.requiredFieldPassword = false,
    this.minLength,
    this.maxLength,
    this.hideVisibleButton,
    @required this.fieldType,
    @required this.name,
  });

  // TextStyle get titleTextStyle {
  //   return TextStyle(color: Colors.white, fontSize: 50.0).merge(this.textStyle);
  // }

  // TextStyle get bodyTextStyle {
  //   return TextStyle(color: Colors.white, fontSize: 24.0).merge(this.textStyle);
  // }
}
