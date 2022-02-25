import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:musicShare/components/formBuilder/formBuilderModel.dart';
import 'package:musicShare/theme/theme.dart';

// ignore: must_be_immutable
class CustomFormBuilder extends StatefulWidget {
  final List<FormBuilderModel> fields;
  final onChanged;
  GlobalKey<FormBuilderState> form;
  CustomFormBuilder({this.fields, this.form, this.onChanged});

  @override
  CustomFormBuilderState createState() => CustomFormBuilderState();
  get getFormState => form;
  set setFormState(val) => {form = val};
}

class CustomFormBuilderState extends State<CustomFormBuilder> {
  bool obscure = true;
  bool obscureConfirm = true;
  GlobalKey<FormBuilderState> formState = GlobalKey<FormBuilderState>();

  // var form;
  @override
  void initState() {
    // Initialize the values here
    super.initState();
    widget.setFormState = formState;
  }

  // @override
  // void dispose() {
  //   // Remember that you have to dispose of the controllers once the widget is ready to be disposed of
  //   form = null;
  //   setFormState = form;
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    widget.setFormState = formState;
    return Container(
        child: FormBuilder(
      key: widget.getFormState,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[getInputs(widget.fields)]),
      // onChanged: () => this.onChanged(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    ));
  }

  Widget getInputs(List<FormBuilderModel> campos) {
    var maskFormatterPhone = new MaskTextInputFormatter(
        mask: '+## (##) # ####-####', filter: {"#": RegExp(r'[0-9]')});
    var maskFormatterCPF = new MaskTextInputFormatter(
        mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
    var maskFormatterDate = new MaskTextInputFormatter(
        mask: '##-##-####', filter: {"#": RegExp(r'[0-9]')});
    var maskCardNumber = new MaskTextInputFormatter(
        mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')});
    var maskCardDate = new MaskTextInputFormatter(
        mask: '##/##', filter: {"#": RegExp(r'[0-9]')});
    // return Text("=========>carregoiu");
    List<Widget> list = [];
    for (var field in campos) {
      // ignore: unnecessary_statements
      List<String Function(String)> validators = [];

      if (field.requiredField ?? false) {
        validators.add(FormBuilderValidators.required(context,
            errorText: "Campo obrigatório!"));
      }

      if (field.requiredFieldPassword ?? false) {
        validators.add(FormBuilderValidators.required(context,
            errorText: "Mínimo de 8 digitos com letras, números e símbolos"));
      }

      var minLength = field.minLength ?? 0;
      if (minLength > 0) {
        validators.add(FormBuilderValidators.minLength(context, minLength,
            errorText: "Mínimo $minLength dígitos!"));
      }

      if (field.name == "email") {
        validators.add(
            FormBuilderValidators.email(context, errorText: "Email inválido!"));
      }

      var hideVisible = field.hideVisibleButton ?? false;

      if (field.fieldType == "inputName") {
        list.add(new Container(
            padding: EdgeInsets.only(top: 15),
            child: FormBuilderTextField(
                cursorColor: Colors.black,
                name: field.name,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]")),
                ],
                style: ThemeStyle.inputTextStyle,
                valueTransformer: field.valueTransformer ?? null,
                validator: FormBuilderValidators.compose(validators),
                initialValue: field.initialValue ?? null,
                onChanged: field.onChanged ?? null,
                maxLength: field.maxLength ?? null,
                decoration: ThemeStyle.inputDecorationDefault.copyWith(
                    prefixIcon: field.icon ?? null,
                    hintText: field.placeholder ?? null))));
      } else if (field.fieldType == "input") {
        list.add(new Container(
            padding: EdgeInsets.only(top: 15),
            child: FormBuilderTextField(
                cursorColor: Colors.black,
                name: field.name,
                controller: field.controller ?? null,
                style: ThemeStyle.inputTextStyle,
                valueTransformer: field.valueTransformer ?? null,
                validator: FormBuilderValidators.compose(validators),
                initialValue: field.initialValue ?? null,
                onChanged: field.onChanged ?? null,
                maxLength: field.maxLength ?? null,
                decoration: ThemeStyle.inputDecorationDefault.copyWith(
                    counterText: '',
                    prefixIcon: field.icon ?? null,
                    hintText: field.placeholder ?? null))));
      } else if (field.fieldType == "inputWhite") {
        list.add(new Container(
            padding: EdgeInsets.only(top: 15),
            child: FormBuilderTextField(
                cursorColor: Colors.black,
                name: field.name,
                style: ThemeStyle.inputTextStyleWhite,
                valueTransformer: field.valueTransformer ?? null,
                validator: FormBuilderValidators.compose(validators),
                initialValue: field.initialValue ?? null,
                onChanged: field.onChanged ?? null,
                maxLength: field.maxLength ?? null,
                decoration: ThemeStyle.inputDecorationLoginWhite.copyWith(
                    prefixIcon: field.icon ?? null,
                    hintText: field.placeholder ?? null))));
      } else if (field.fieldType == "inputWhiteLogin") {
        list.add(new Container(
            padding: EdgeInsets.only(top: 15),
            child: FormBuilderTextField(
                cursorColor: Colors.white,
                name: field.name,
                onSubmitted: field.onSubmitted,
                style: ThemeStyle.inputTextStyleWhite,
                valueTransformer: field.valueTransformer ?? null,
                validator: FormBuilderValidators.compose(validators),
                initialValue: field.initialValue ?? null,
                onChanged: field.onChanged ?? null,
                maxLength: field.maxLength ?? null,
                decoration: ThemeStyle.inputDecorationLoginWhite.copyWith(
                    prefixIcon: field.icon ?? null,
                    hintText: field.placeholder ?? null))));
      } else if (field.fieldType == "phone") {
        list.add(new Container(
            padding: EdgeInsets.only(top: 15),
            child: FormBuilderTextField(
                cursorColor: Colors.black,
                inputFormatters: [maskFormatterPhone],
                name: field.name,
                initialValue: field.initialValue ?? null,
                style: ThemeStyle.inputTextStyle,
                validator: FormBuilderValidators.compose(validators),
                decoration: ThemeStyle.inputDecorationDefault.copyWith(
                    prefixIcon: field.icon ?? null,
                    hintText: field.placeholder ?? null))));
      } else if (field.fieldType == "date") {
        list.add(new Container(
            padding: EdgeInsets.only(top: 15),
            child: Container(
              child: FormBuilderTextField(
                  cursorColor: Colors.black,
                  inputFormatters: [maskFormatterDate],
                  name: field.name,
                  style: ThemeStyle.inputTextStyle,
                  validator: FormBuilderValidators.compose(validators),
                  decoration: ThemeStyle.inputDecorationDefault.copyWith(
                      prefixIcon: field.icon ?? null,
                      hintText: field.placeholder ?? null)),
            )));
      } else if (field.fieldType == "cpf") {
        list.add(new Container(
            padding: EdgeInsets.only(top: 15),
            child: FormBuilderTextField(
                cursorColor: Colors.black,
                maxLength: field.maxLength ?? 14,
                inputFormatters: [maskFormatterCPF],
                initialValue: field.initialValue ?? null,
                name: field.name,
                keyboardType: TextInputType.number,
                style: ThemeStyle.inputTextStyle,
                validator: FormBuilderValidators.compose(validators),
                decoration: ThemeStyle.inputDecorationDefault.copyWith(
                    counterText: '',
                    prefixIcon: field.icon ?? null,
                    hintText: field.placeholder ?? null))));
      } else if (field.fieldType == "password") {
        list.add(
          new Container(
            padding: EdgeInsets.only(top: 15),
            child: FormBuilderTextField(
                cursorColor: Colors.black,
                name: field.name,
                obscureText: obscure,
                style: ThemeStyle.inputTextStyle,
                validator: FormBuilderValidators.compose(validators),
                decoration: ThemeStyle.inputDecorationDefault.copyWith(
                    prefixIcon: field.icon ?? null,
                    suffixIcon: !hideVisible
                        ? TextButton(
                            onPressed: () {
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                            child: Icon(
                              obscure ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black,
                            ),
                          )
                        : null,
                    hintText: field.placeholder ?? null)),
          ),
        );
      } else if (field.fieldType == "confirmPassword") {
        list.add(
          new Container(
            padding: EdgeInsets.only(top: 15),
            child: FormBuilderTextField(
                cursorColor: Colors.black,
                name: field.name,
                obscureText: obscureConfirm,
                style: ThemeStyle.inputTextStyle,
                validator: FormBuilderValidators.compose(validators),
                decoration: ThemeStyle.inputDecorationDefault.copyWith(
                    prefixIcon: field.icon ?? null,
                    suffixIcon: !hideVisible
                        ? TextButton(
                            onPressed: () {
                              setState(() {
                                obscureConfirm = !obscureConfirm;
                              });
                            },
                            child: Icon(
                              obscureConfirm
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                          )
                        : null,
                    hintText: field.placeholder ?? null)),
          ),
        );
      } else if (field.fieldType == "passwordWhite") {
        list.add(
          new Container(
            padding: EdgeInsets.only(top: 15),
            child: FormBuilderTextField(
                cursorColor: Colors.black,
                name: field.name,
                obscureText: obscure,
                style: ThemeStyle.inputTextStyleWhite,
                validator: FormBuilderValidators.compose(validators),
                decoration: ThemeStyle.inputDecorationPasswordWhite.copyWith(
                    prefixIcon: field.icon ?? null,
                    suffixIcon: !hideVisible
                        ? TextButton(
                            onPressed: () {
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                            child: Icon(
                              obscure ? Icons.visibility : Icons.visibility_off,
                              color: Colors.white,
                            ),
                          )
                        : null,
                    hintText: field.placeholder ?? null)),
          ),
        );
      } else if (field.fieldType == "passwordWhiteLogin") {
        list.add(
          new Container(
            padding: EdgeInsets.only(top: 15),
            child: FormBuilderTextField(
                cursorColor: Colors.white,
                name: field.name,
                obscureText: obscure,
                onSubmitted: field.onSubmitted,
                style: ThemeStyle.inputTextStyleWhite,
                validator: FormBuilderValidators.compose(validators),
                decoration: ThemeStyle.inputDecorationPasswordWhite.copyWith(
                    prefixIcon: field.icon ?? null,
                    suffixIcon: !hideVisible
                        ? TextButton(
                            onPressed: () {
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                            child: Icon(
                              obscure ? Icons.visibility : Icons.visibility_off,
                              color: Colors.white,
                            ),
                          )
                        : null,
                    hintText: field.placeholder ?? null)),
          ),
        );
      } else if (field.fieldType == "checkBox") {
        list.add(
          new Container(
            padding: EdgeInsets.only(top: 15),
            child: FormBuilderCheckbox(
                initialValue: false,
                name: field.name,
                validator: FormBuilderValidators.equal(
                  context,
                  true,
                  errorText:
                      'Você deve aceitar os termos de uso para continuar!',
                ),
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Concordo com os ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'termos de uso',
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                decoration: ThemeStyle.inputDecoratioCheckBox.copyWith(
                    prefixIcon: field.icon ?? null,
                    hintText: field.placeholder ?? null)),
          ),
        );
      } else if (field.fieldType == "select") {
        list.add(new Container(
          padding: EdgeInsets.only(top: 15),
          child: FormBuilderDropdown(
            name: field.name,
            validator: field.requiredField == true
                ? FormBuilderValidators.compose([
                    FormBuilderValidators.required(context,
                        errorText: "Campo obrigatório")
                  ])
                : null,
            style: ThemeStyle.inputTextStyle,
            decoration: ThemeStyle.inputDecorationDefault.copyWith(
                prefixIcon: field.icon ?? null,
                hintText: field.placeholder ?? null,
                fillColor: Colors.red),
            dropdownColor: ThemeStyle.baseInputColor,
            isExpanded: true,
            items: field.selectOptions.map((option) {
              return DropdownMenuItem(
                child: Text("${option[1]}"),
                value: option[0],
              );
            }).toList(),
          ),
        ));
      } else if (field.fieldType == "dateRangePicker") {
        list.add(new Container(
            padding: EdgeInsets.only(top: 15),
            child: FormBuilderDateRangePicker(
                name: field.name,
                firstDate: DateTime(1970),
                lastDate: DateTime(2030),
                decoration: field.loginStyle
                    ? ThemeStyle.inputDecoratioCheckBox.copyWith(
                        prefixIcon: field.icon ?? null,
                        hintText: field.placeholder ?? null)
                    : ThemeStyle.inputDecoratioCheckBox.copyWith(
                        prefixIcon: field.icon ?? null,
                        hintText: field.placeholder ?? null))));
      }
      if (field.fieldType == "cardNumber") {
        // list.add(new Container(
        //     padding: EdgeInsets.only(top: 15),
        //     child:FormBuilderTextField(

        //         name: field.name,
        //         style: ThemeStyle.inputTextStyle,
        //         inputFormatters: [maskCardNumber],
        //         valueTransformer: field.valueTransformer ?? null,
        //         maxLength: field.maxLength ?? 16,
        //         validator: FormBuilderValidators.compose(validators),
        //         initialValue: field.initialValue ?? null,
        //         onChanged: field.onChanged ?? null,
        //         onTap: field.onTap ?? null,
        //         keyboardType: TextInputType.number,
        //         decoration: ThemeStyle.inputDecorationDefault.copyWith(
        //             prefixIcon: field.icon ?? null,
        //             hintText: field.placeholder ?? null))));
        list.add(new Container(
            padding: EdgeInsets.only(top: 15),
            child: FormBuilderTextField(

                // maxLength: field.maxLength ?? 14,
                inputFormatters: [maskCardNumber],
                name: field.name,
                keyboardType: TextInputType.number,
                style: ThemeStyle.inputTextStyle,
                initialValue: field.initialValue ?? null,
                validator: FormBuilderValidators.compose(validators),
                decoration: ThemeStyle.inputDecorationDefault.copyWith(
                    counterText: '',
                    prefixIcon: field.icon ?? null,
                    hintText: field.placeholder ?? null))));
      }
      if (field.fieldType == "cardDate") {
        // list.add(new Container(
        //     padding: EdgeInsets.only(top: 15),
        //     child:FormBuilderTextField(

        //         name: field.name,
        //         style: ThemeStyle.inputTextStyle,
        //         inputFormatters: [maskCardDate],
        //         valueTransformer: field.valueTransformer ?? null,
        //         maxLength: field.maxLength ?? 16,
        //         validator: FormBuilderValidators.compose(validators),
        //         initialValue: field.initialValue ?? null,
        //         onChanged: field.onChanged ?? null,
        //         onTap: field.onTap ?? null,
        //         keyboardType: TextInputType.number,
        //         decoration: ThemeStyle.inputDecorationDefault.copyWith(
        //             prefixIcon: field.icon ?? null,
        //             hintText: field.placeholder ?? null))));
        list.add(new Container(
            padding: EdgeInsets.only(top: 15),
            child: FormBuilderTextField(
                maxLength: field.maxLength ?? 5,
                inputFormatters: [maskCardDate],
                initialValue: field.initialValue ?? null,
                name: field.name,
                keyboardType: TextInputType.number,
                style: ThemeStyle.inputTextStyle,
                validator: FormBuilderValidators.compose(validators),
                decoration: ThemeStyle.inputDecorationDefault.copyWith(
                    counterText: '',
                    prefixIcon: field.icon ?? null,
                    hintText: field.placeholder ?? null))));
      }
    }

    return new Column(
      children: list,
    );
  }
}
