import 'package:flutter/material.dart';
import 'package:musicShare/theme/theme.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'dart:math';

class DefaultButton extends StatefulWidget {
  DefaultButton({Key key, this.title, this.action, this.state = "normal"})
      : super(key: key);

  final String title;
  final action;
  final String state;

  @override
  DefaultButtonState createState() => DefaultButtonState();
}

class DefaultButtonState extends State<DefaultButton> {
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  ButtonState stateTextWithIconMinWidthState = ButtonState.idle;

  Widget buildCustomButton() {
    var progressTextButton = ProgressButton(
      stateWidgets: {
        ButtonState.idle: Text(
          widget.title,
        ),
        ButtonState.loading: Text(
          "CARREGANDO",
          style: TextStyle(color: Colors.white),
        ),
        ButtonState.fail: Icon(
          Icons.cancel_outlined,
          color: Colors.white,
          size: 40,
        ),
        ButtonState.success: Icon(
          Icons.check,
          color: Colors.white,
          size: 40,
        )
      },
      stateColors: {
        ButtonState.idle: ThemeStyle.secondaryColor,
        ButtonState.loading: ThemeStyle.buttonLoading,
        ButtonState.fail: ThemeStyle.error,
        ButtonState.success: ThemeStyle.success,
      },
      progressIndicatorAlignment: MainAxisAlignment.spaceAround,
      onPressed: widget.action,
      state: getState(widget.state),
    );
    return progressTextButton;
  }

  Widget buildTextWithIcon() {
    return ProgressButton.icon(iconedButtons: {
      ButtonState.idle: IconedButton(
          text: "ENVIAR",
          icon: Icon(Icons.send, color: Colors.white),
          color: Colors.deepPurple.shade500),
      ButtonState.loading:
          IconedButton(text: "Carregando", color: Colors.deepPurple.shade700),
      ButtonState.fail: IconedButton(
          text: "Erro",
          icon: Icon(Icons.cancel, color: Colors.white),
          color: Colors.red.shade300),
      ButtonState.success: IconedButton(
          text: "",
          icon: Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          color: Colors.green.shade400)
    }, onPressed: onPressedIconWithText, state: stateTextWithIcon);
  }

  Widget buildTextWithIconWithMinState() {
    return ProgressButton.icon(
      iconedButtons: {
        ButtonState.idle: IconedButton(
            text: "Send",
            icon: Icon(Icons.send, color: Colors.white),
            color: Colors.deepPurple.shade500),
        ButtonState.loading:
            IconedButton(text: "Loading", color: Colors.deepPurple.shade700),
        ButtonState.fail: IconedButton(
            text: "Failed",
            icon: Icon(Icons.cancel, color: Colors.white),
            color: Colors.red.shade300),
        ButtonState.success: IconedButton(
            icon: Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            color: Colors.green.shade400)
      },
      onPressed: onPressedIconWithMinWidthStateText,
      state: stateTextWithIconMinWidthState,
      minWidthStates: [ButtonState.loading, ButtonState.success],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: buildCustomButton());
  }

  ButtonState getState(state) {
    if (state == "normal") return ButtonState.idle;
    if (state == "loading") return ButtonState.loading;
    if (state == "fail") return ButtonState.fail;
    if (state == "success") return ButtonState.success;
    return ButtonState.idle;
  }

  void onPressedCustomButton() {
    setState(() {
      switch (stateOnlyText) {
        case ButtonState.idle:
          stateOnlyText = ButtonState.loading;
          break;
        case ButtonState.loading:
          stateOnlyText = ButtonState.fail;
          break;
        case ButtonState.success:
          stateOnlyText = ButtonState.idle;
          break;
        case ButtonState.fail:
          stateOnlyText = ButtonState.success;
          break;
      }
    });
  }

  void onPressedIconWithText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            stateTextWithIcon = Random.secure().nextBool()
                ? ButtonState.success
                : ButtonState.fail;
          });
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
  }

  void onPressedIconWithMinWidthStateText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIconMinWidthState = ButtonState.loading;
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            stateTextWithIconMinWidthState = Random.secure().nextBool()
                ? ButtonState.success
                : ButtonState.fail;
          });
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIconMinWidthState = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIconMinWidthState = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIconMinWidthState = stateTextWithIconMinWidthState;
    });
  }
}
