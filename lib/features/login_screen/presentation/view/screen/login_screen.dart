import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/const Widgets/app_background.dart';
import '../../../../../core/utils/app_routes.dart';
import '../widgets/login_header.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = AppRoute.loginRoute;
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                LoginTitleSection(),
                SizedBox(height: 20),
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
