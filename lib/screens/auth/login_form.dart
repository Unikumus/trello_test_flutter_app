
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello_app/bloc/login_bloc/login_bloc.dart';
import 'package:trello_app/repositories/repositories.dart';
import 'package:trello_app/utils/color.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepository;

  LoginForm({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState(userRepository);
}

class _LoginFormState extends State<LoginForm> {
  final UserRepository userRepository;

  _LoginFormState(this.userRepository);

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String _loginValidate(String value) {
    if (value.length < 4) {
      return "Minimum is 4 characters";
    } else
      return null;
  }

  String _passwordValidate(String value) {
    if (value.length < 8) {
      return "Minimum is 8 characters";
    } else
      return null;
  }

  _validate(String value) {
    if (formkey.currentState.validate()) {
      print("validate");
    } else {
      print("not validate");
    }
  }

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          email: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Login failed."),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColor.black1,
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding:
                  const EdgeInsets.only(right: 20.0, left: 20.0, top: 80.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Container(
                          height: 200.0,
                          padding: EdgeInsets.only(bottom: 20.0, top: 40.0),
                          child: Text(
                            "KANBAN",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                          )),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        validator: _loginValidate,
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold),
                        controller: _usernameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red[500], width: 1.0),
                              borderRadius: BorderRadius.circular(30.0)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                              borderRadius: BorderRadius.circular(30.0)),
                          prefixIcon:
                              Icon(EvaIcons.personOutline, color: Colors.teal),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius: BorderRadius.circular(30.0)),
                          contentPadding:
                              EdgeInsets.only(left: 10.0, right: 10.0),
                          labelText: "Login",
                          hintStyle: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        autocorrect: false,
                        onChanged: _validate,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: _passwordValidate,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold),
                        controller: _passwordController,
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red[500], width: 1.0),
                              borderRadius: BorderRadius.circular(30.0)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                              borderRadius: BorderRadius.circular(30.0)),
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            EvaIcons.lockOutline,
                            color: Colors.teal,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius: BorderRadius.circular(30.0)),
                          contentPadding:
                              EdgeInsets.only(left: 10.0, right: 10.0),
                          labelText: "Password",
                          hintStyle: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        autocorrect: false,
                        obscureText: true,
                        onChanged: _validate,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                                height: 45,
                                child: state is LoginLoading
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 25.0,
                                                width: 25.0,
                                                child:
                                                    CupertinoActivityIndicator(),
                                              )
                                            ],
                                          ))
                                        ],
                                      )
                                    : RaisedButton(
                                        color: Colors.teal,
                                        disabledColor: Colors.teal,
                                        disabledTextColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        onPressed: _onLoginButtonPressed,
                                        child: Text("LOG IN",
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
