import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/const Widgets/custom_button.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_texts.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/validator.dart';
import '../../controller/login_cubit.dart';
import '../../controller/login_state.dart';
import '../../../../../core/const Widgets/custom_text_form_field.dart';

class LoginBuilder extends StatefulWidget {
  const LoginBuilder({super.key});

  @override
  State<LoginBuilder> createState() => LoginBuilderState();
}

class LoginBuilderState extends State<LoginBuilder> {
  final formKey = GlobalKey<FormState>();
  final nationalIdController = TextEditingController();
  final passwordController = TextEditingController();
  final nationalIdFocus = FocusNode();
  final passwordFocus = FocusNode();
  final nationalIdFormatter = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(14),
  ];

  @override
  void dispose() {
    nationalIdController.dispose();
    passwordController.dispose();
    nationalIdFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final isLoading = state is LoginLoadingState;
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                fillColor: const Color(0xFF28282C).withOpacity(0.85),
                focusNode: nationalIdFocus,
                hintText: AppTexts.enterId,
                controller: nationalIdController,
                keyboardType: TextInputType.number,
                validator: Validator.validateNationalId,
                inputFormatters: nationalIdFormatter,
              ),
              SizedBox(height: 0.015.sh),
              CustomTextFormField(
                fillColor: const Color(0xFF28282C).withOpacity(0.85),
                focusNode: passwordFocus,
                hintText: AppTexts.enterPassword,
                controller: passwordController,
                isPassword: true,
                validator: Validator.validatePassword,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(AppTexts.forgetPassword, style: AppStyles.white16medium),
                ),
              ),
              SizedBox(height: 0.03.sh),
              CustomElevatedButton(
                backgroundColor: AppColors.whiteColor,
                textColor: AppColors.darkBlueColor,
                width: double.infinity,
                text: AppTexts.loginInButton,
                fontSize: 18.sp,
                isLoading: isLoading,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<LoginCubit>().loginUser(
                          nationalId: nationalIdController.text,
                          password: passwordController.text,
                        );
                  }
                },
              ),
              SizedBox(height: 0.015.sh),
            ],
          ),
        );
      },
    );
  }
}
