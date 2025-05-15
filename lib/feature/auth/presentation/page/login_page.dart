import 'package:counter_demo_bloc/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:counter_demo_bloc/feature/auth/presentation/bloc/auth_event.dart';
import 'package:counter_demo_bloc/feature/auth/presentation/bloc/auth_state.dart';
import 'package:counter_demo_bloc/res/constants/texts.dart';
import 'package:counter_demo_bloc/res/widgets/app_button.dart';
import 'package:counter_demo_bloc/res/widgets/app_text_field.dart';
import 'package:counter_demo_bloc/res/widgets/context_extension.dart';
import 'package:counter_demo_bloc/theme/colors.dart';
import 'package:counter_demo_bloc/utils/printer.dart';
import 'package:counter_demo_bloc/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController mobileController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isChecked = false;

  @override
  void dispose() {
    super.dispose();
    mobileController.clear();
  }

  addEvent() {
    context.read<AuthBloc>().add(OnSendOtpEvent(mobile: mobileController.text));
  }

  _listener(BuildContext context, AuthState state) {
    if (state is SendOtpSuccessState) {
      Utils.toastMessage(context, message: "Send OTP successfully!");
      //paas here your route
    }
    if (state is SendOtpFailureState) {
      Utils.toastMessage(context, message: state.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlocListener<AuthBloc, AuthState>(
        listener: _listener,

        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.05),
                      Text(
                        "Welcome to Sing in",
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontSize: 28,
                        ),
                      ),
                      Text(
                        texts.letsLogin,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: height * 0.04),

                      AppTextField(
                        labelText: texts.mobile,
                        mandatory: true,
                        controller: mobileController,
                        keyBoardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        prefixIcon: SizedBox(
                          width: 60,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                child: Icon(
                                  Icons.phone_android,
                                  color: appColors.editTextColor,
                                ),
                              ),
                              Container(
                                height: 35,
                                width: 2,
                                color: appColors.borderColor,
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                        ),
                        textCapitalization: TextCapitalization.none,
                        hintText: "Enter Mobile Number",
                        validator:
                            (val) => Utils.validateMobileNumber(val ?? ''),
                      ),

                      SizedBox(height: height * 0.04),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            checkColor: appColors.appWhite,
                            fillColor: WidgetStateProperty.resolveWith<Color>((
                              states,
                            ) {
                              if (states.contains(WidgetState.selected)) {
                                return appColors.primary;
                              }
                              return appColors.appWhite;
                            }),
                            side: BorderSide(
                              color: appColors.borderColor,
                              width: 2, // Border width
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            visualDensity: VisualDensity(
                              horizontal: -4,
                              vertical: -4,
                            ),

                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),

                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: texts.iAgree,
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                          color: appColors.titleColor1,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),

                                  TextSpan(
                                    text: texts.termUse,
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                          color: appColors.primary,
                                          decoration: TextDecoration.underline,
                                          decorationColor: appColors.primary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                    recognizer:
                                        TapGestureRecognizer()..onTap = () {},
                                  ),
                                  TextSpan(
                                    text: texts.and,
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                          color: appColors.titleColor1,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  TextSpan(
                                    text: texts.privacy,
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                          color: appColors.primary,
                                          decoration: TextDecoration.underline,
                                          decorationColor: appColors.primary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                    recognizer:
                                        TapGestureRecognizer()..onTap = () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return AppButton(
                            isLoading: state is AuthLoadingState,
                            title: texts.sendOTP,
                            onPressed: () {
                              if (formKey.currentState == null ||
                                  formKey.currentState!.validate()) {
                                if (!isChecked) {
                                  // here you show your message
                                  Printer.prettyPrint(
                                    "Accept terms and conditions",
                                  );
                                } else {
                                  addEvent();
                                }
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
