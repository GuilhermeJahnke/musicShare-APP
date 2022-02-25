// ignore_for_file: invalid_return_type_for_catch_error, must_be_immutable

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:musicShare/components/defaultButton/defaultButton.dart';
import 'package:musicShare/components/formBuilder/formBuilder.dart';
import 'package:musicShare/components/formBuilder/formBuilderModel.dart';
import 'package:musicShare/services/music.dart';
import 'package:musicShare/theme/theme.dart';
import 'package:progress_state_button/progress_button.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

Random rnd = new Random();
int randomNumber = rnd.nextInt(3);

/// Component UI
class changeMusic extends StatefulWidget {
  CustomFormBuilder formStateLogin;

  @override
  changeMusicState createState() => changeMusicState();
}

/// Component UI
class changeMusicState extends State<changeMusic>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  }

  var formLoginT;
  static final GlobalKey<FormBuilderState> formLogin =
      GlobalKey<FormBuilderState>();
  String stateOnlyText = "normal";
  Widget build(BuildContext context) {
    print("enter login");
    final inputList = [
      new FormBuilderModel(
          fieldType: "inputWhite",
          name: "musicName",
          loginStyle: true,
          onSubmitted: (value) {
            onPressedCustomButton();
          },
          placeholder: "Nome ou link da música",
          icon: Icon(Icons.music_note, color: Colors.white70))
    ];

    formLoginT = new CustomFormBuilder(
      fields: inputList,
      form: formLogin,
    );
    widget.formStateLogin = formLoginT;

    void _handleOnPressed() {
      setState(() {
        isPlaying = !isPlaying;
        isPlaying
            ? _animationController.forward()
            : _animationController.reverse();
      });
    }

    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeStyle.baseColorDarker,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0))),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.skip_previous,
                                  color: Colors.black,
                                  size: 30,
                                )),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0))),
                              child: IconButton(
                                iconSize: 30,
                                splashColor: Colors.white,
                                icon: AnimatedIcon(
                                  icon: AnimatedIcons.play_pause,
                                  progress: _animationController,
                                ),
                                onPressed: () => _handleOnPressed(),
                              )),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0))),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.skip_previous,
                                  color: Colors.black,
                                  size: 30,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      formLoginT,
                      SizedBox(height: 18),
                      DefaultButton(
                          title: 'ENVIAR',
                          action: onPressedCustomButton,
                          state: stateOnlyText),
                    ],
                  ),
                  SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  onPressedCustomButton() async {
    final musicService = new MusicService();
    final prefs = await SharedPreferences.getInstance();
    print('FORM');
    final form = formLoginT.getFormState;

    print(form.currentState.fields);
    changeButton("loading");
    if (!form.currentState.validate()) {
      print('INVALID FORM');
      changeButton("normal");
      return;
    }
    // Navigator.push(
    //                         context,
    //                         MaterialPageRoute(

    //                           builder: (context) => ApplePay()),
    //                             // builder: (context) => MyDrawerPage(value.data)),
    //                       );
    //                       return;
    var params = {
      // "login": "teste1@teste"
      "login": form.currentState.fields["login"].value,
      // "password": "12345678"
      "password": form.currentState.fields["password"].value,
    };
    print("params $params");
    // var login = await auth.login(params);
    FocusScope.of(context).unfocus();
    musicService
        .login(params)
        .then((response) => {
              if (response.statusCode == 200 || response.statusCode == 201)
                {
                  prefs.setString('token', response.data["token"]),
                  changeButton("success"),
                }
              else if (response.statusCode == 400 ||
                  response.statusCode == 401 ||
                  response.statusCode == 500)
                {errorToaster(response)}
            })
        .catchError((error) => {changeButton("fail")});
  }

  startTime() async {
    return new Timer(Duration(milliseconds: 200000), changeButton("normal"));
  }

  changeButton(state) {
    setState(() {
      if (state == "normal")
        stateOnlyText = "normal";
      else if (state == "loading")
        stateOnlyText = "loading";
      else if (state == "fail") {
        stateOnlyText = "fail";
        // startTime();
      } else if (state == "success") {
        stateOnlyText = "success";
        // startTime();
      }

      print("state $stateOnlyText");
    });
  }

  errorToaster(response) {
    var message = response.data["error"] ??
        response.data["message"] ??
        response.statusCode.toString();
    changeButton("fail");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            SizedBox(width: 8),
            Flexible(child: Text(message))
          ],
        ),
        backgroundColor: ThemeStyle.error,
      ),
    );
    Timer(Duration(seconds: 3), () {
      changeButton("normal");
    });
  }
}
