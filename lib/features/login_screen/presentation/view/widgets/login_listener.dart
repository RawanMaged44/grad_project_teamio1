import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/login_cubit.dart';
import '../../controller/login_state.dart';
import '../../../../../core/utils/app_routes.dart';

class LoginListener extends StatelessWidget {
  final Widget child;
  const LoginListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Login successful!"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.pushReplacementNamed(
              context,
              AppRoute.homeRoute,
              arguments: state.userName,
            );
          });
        }
        if (state is LoginErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: child,
    );
  }
}