import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:promina_task/common/dialogs.dart';
import 'package:promina_task/common/resources/assets_manager.dart';
import 'package:promina_task/common/resources/font_manager.dart';
import 'package:promina_task/common/resources/strings_manager.dart';

import '../../../common/resources/routes_manager.dart';
import '../../blocs/auth/auth_bloc.dart';

class LoginView extends StatelessWidget {
  final loginFormKey = GlobalKey<FormBuilderState>();
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.loginBackground),
                fit: BoxFit.cover,
              ),
            )),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.myGallery,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                30.verticalSpace,
                BlurryContainer(
                  color: Colors.white.withOpacity(.4),
                  width: 388.w,
                  blur: 10,
                  padding:
                      EdgeInsets.symmetric(vertical: 32.h, horizontal: 32.w),
                  borderRadius: BorderRadius.circular(32.w),
                  child: Column(
                    children: [
                      Text(
                        AppStrings.login.toUpperCase(),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      36.verticalSpace,
                      BlocListener<AuthBloc, AuthState>(
                        listener: (context, state) async {
                          if (state is AuthLoadingState) {
                            showAlertDialog(
                                context: context,
                                title: "Log in ......",
                                isLoading: true);
                          } else if (state is AuthFailureState) {
                            Navigator.of(context).pop();
                            showAlertDialog(
                                context: context, title: state.failure.message);
                          } else if (state is AuthLoggedInState) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                Routes.galleryRoute, (_) => false);
                          }
                        },
                        child: FormBuilder(
                          key: loginFormKey,
                          child: Column(
                            children: <Widget>[
                              FormBuilderTextField(
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                name: 'email',
                                decoration: const InputDecoration(
                                    hintText: AppStrings.username),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: AppStrings.required),
                                  FormBuilderValidators.email(
                                      errorText: AppStrings.emailError),
                                ]),
                              ),
                              36.verticalSpace,
                              FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                name: 'password',
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: AppStrings.password),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: AppStrings.required),
                                ]),
                              ),
                              36.verticalSpace,
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      login(context);
                                    },
                                    child: Text(
                                      AppStrings.submit.toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              fontWeight:
                                                  FontWeightManager.semiBold),
                                    )),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  login(BuildContext context) {
    if (!loginFormKey.currentState!.saveAndValidate()) {
      return;
    }
    context.read<AuthBloc>().add(
        AuthLoginEvent(loginFormMap: loginFormKey.currentState?.value ?? {}));
  }
}
