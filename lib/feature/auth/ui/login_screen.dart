import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_pack/utils/animations.dart';

import '../../../routes/route_names.dart';
import '../../../utils/assets.dart';
import '../../../utils/utils.dart';
import '../../../utils/validators.dart';
import '../../../widgets/buttons/button.dart';
import '../../../widgets/dialogs_and_snackbars/error_snackbar.dart';
import '../../../widgets/scaffold.dart';
import '../../../widgets/text_fields/text_form_field.dart';
import '../bloc/auth/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool passwordObscured = true;

  bool buttonActive = false;

  void validate() {
    buttonActive = _formKey.currentState!.validate();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInProcess) {
          Dialogs.showModal(
              context,
              const Center(
                child: AppAnimations.circleIndicator,
              ));
        } else {
          Dialogs.hide(context);
        }
        if (state is AuthFailState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(AppSnackBars.snackBar(state.e.toString()));
        }
      },
      child: CustomScaffold(
          canPop: false,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        onChange: (b) {
                          validate();
                        },
                        validator: Validator.email,
                        controller: emailController,
                        labelText: 'email',
                        hintText: 'email',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: SvgPicture.asset(
                          Assets.icons('email.svg'),
                        ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      CustomTextFormField(
                        onChange: (b) {
                          validate();
                        },
                        controller: passwordController,
                        validator: Validator.password,
                        labelText: 'password',
                        hintText: 'password',
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: SvgPicture.asset(
                          Assets.icons('lock.svg'),
                        ),
                        suffixIcon: InkWell(
                          child: SvgPicture.asset(
                            passwordObscured
                                ? Assets.icons('uil_eye-slash.svg')
                                : Assets.icons('uil_eye.svg'),
                          ),
                          onTap: () {
                            setState(() {
                              passwordObscured = !passwordObscured;
                            });
                          },
                        ),
                        obscured: passwordObscured,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text.rich(TextSpan(
                              text: 'forgot password',
                              style: AppTypography.font12w400,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, AppRouteNames.recovery);
                                }))
                        ],
                      ),
                      const SizedBox(
                        height: 55,
                      ),
                      CustomTextButton(
                        text: 'login',
                        onTap: () {
                          context.read<AuthCubit>().signInWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim());
                        },
                        isActive: buttonActive,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "no account ",
                            style: AppTypography.font12w400),
                        TextSpan(
                            text: 'sign up',
                            style: AppTypography.font16w600,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                    context, AppRouteNames.registration);
                              }),
                      ])),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
