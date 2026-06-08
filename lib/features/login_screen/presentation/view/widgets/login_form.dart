import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/login_cubit.dart';
import '../../controller/login_state.dart';
import 'login_builder.dart';
import 'login_listener.dart';


class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginListener(
      child: const LoginBuilder(),
    );
  }
}